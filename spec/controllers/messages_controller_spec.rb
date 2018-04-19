require "rails_helper"

RSpec.describe MessagesController, type: :controller do
  before do
    login_user
  end

  let!(:author)      { create(:user, nickname: "author") }
  let!(:destinatary) { create(:user, nickname: "destinatary") }

  let!(:message)  { create(:message,
                            author: author,
                            destinatary_nickname:
                            controller.current_user.nickname) }

  let!(:message_readed) { create(:message, :read,
                                  author: author,
                                  destinatary_nickname:
                                  controller.current_user.nickname) }

  let!(:message_important) { create(:message, :important,
                                    author: author,
                                    destinatary_nickname:
                                    controller.current_user.nickname) }

  let!(:message_archived) { create(:message, :archived,
                                    author: author,
                                    destinatary_nickname:
                                    controller.current_user.nickname) }

  let!(:message_sent) { create(:message,
                                author: controller.current_user,
                                destinatary_nickname: destinatary.nickname) }

  it { is_expected.to use_before_action :authenticate_user! }
  it { is_expected.to use_before_action :set_message }
  it { is_expected.to use_before_action :set_messages }

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "has correct title" do
      get :index
      expect(assigns(:page_title)).to eq(
        I18n.t('application_layout.title.inbox'))
    end

    it "has current_user_inbox @messages" do
      get :index
      expect(assigns(:messages).count).to eq(3)
    end
  end

  describe "#sent_box" do
    it "renders the sent_box template" do
      get :sent_box
      expect(response).to render_template(:sent_box)
    end

    it "has a 200 status code" do
      get :sent_box
      expect(response.status).to eq(200)
    end

    it "has correct title" do
      get :sent_box
      expect(assigns(:page_title)).to eq(
        I18n.t('application_layout.title.sent'))
    end

    it "has current_user_sent @messages" do
      get :sent_box
      expect(assigns(:messages).count).to eq(1)
    end
  end

  describe "#important_box" do
    it "renders the important_box template" do
      get :important_box
      expect(response).to render_template(:important_box)
    end

    it "has a 200 status code" do
      get :important_box
      expect(response.status).to eq(200)
    end

    it "has correct title" do
      get :important_box
      expect(assigns(:page_title)).to eq(
        I18n.t('application_layout.title.important'))
    end

    it "has current_user_sent @messages" do
      get :important_box
      expect(assigns(:messages).count).to eq(1)
    end
  end

  describe "#show" do
    it "renders the show template" do
      get :show, params: { id: message.id }
      expect(response).to render_template(:show)
    end

    it "has a 200 status code" do
      get :show, params: { id: message.id }
      expect(response.status).to eq(200)
    end

    it "has correct title" do
      get :show, params: { id: message.id }
      expect(assigns(:page_title)).to eq(
        "Reading Message: #{message.title}")
    end

    it "has the show @message" do
      get :show, params: { id: message.id }
      expect(assigns(:message).present?).to eq(true)
    end
  end

  describe "#create" do
    let(:new_message) { build(:message,
      destinatary_nickname: controller.current_user.nickname) }

    it "create a new Message" do
      get :create, params: { message: new_message.attributes }
      expect(assigns(:message).present?).to eq(true)
    end
  end

  describe "#destroy" do
    it "destroy(archive) the referent id Message" do
      get :destroy, params: { id: message.id }
      expect(assigns(:message).archived).to eq(true)
    end
  end
end
