require "rails_helper"

RSpec.describe Message, type: :model do
  describe "Should Respond" do
    it { should respond_to :content }
    it { should respond_to :author }
    it { should respond_to :destinatary }
    it { should respond_to :title }
    it { should respond_to :archived }
    it { should respond_to :archive_date }
    it { should respond_to :read }
    it { should respond_to :read_date }
    it { should respond_to :important }
    it { should respond_to :destinatary_nickname }
  end

  describe "Associations" do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:destinatary).class_name('User') }
  end

  describe "Methods" do
    let!(:author)      { create(:user) }
    let!(:destinatary) { create(:user) }
    let!(:message)     { create(:message,
                                author: author,
                                destinatary: destinatary,
                                destinatary_nickname: destinatary.nickname) }

    it "#destinatary_exist?" do
      expect(message.destinatary_exist?).to eq(destinatary.id)
    end

    it "#read_now" do
      message.read_now
      expect(message.read).to eq(true)
      expect(message.read_date.present?).to eq(true)
    end

    it "#important_now" do
      message.important_now
      expect(message.important).to eq(true)
    end

    it "#archive_now" do
      message.archive_now
      expect(message.archived).to eq(true)
      expect(message.archive_date.present?).to eq(true)
    end

    it "#unarchive_now" do
      message.unarchive_now
      expect(message.archived).to eq(false)
    end
  end

  context "Validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end

  describe "Factory" do
    let!(:destinatary)  { create(:user) }
    let!(:message)      { create(:message,
      destinatary_nickname: destinatary.nickname) }

    it { expect(message).to be_a Message }
    it { expect(message).to be_valid }
  end
end
