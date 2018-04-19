class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, :is_owner, only: [:show, :destroy, :make_important]
  before_action :set_messages, only: [:index, :new, :show,
    :sent_box, :archived_box, :important_box]

  def index
    @page_title = t('application_layout.title.inbox')
    @messages = Message.current_user_inbox(current_user)
  end

  def make_important
    @message.important_now
    redirect_to messages_url
  end

  def sent_box
    @page_title = t('application_layout.title.sent')
    @messages = Message.current_user_sent(current_user)
  end

  def important_box
    @page_title = t('application_layout.title.important')
    @messages = Message.current_user_important(current_user)
  end

  def archived_box
    @page_title = t('application_layout.title.archived')
    @messages = Message.current_user_archived(current_user)
  end

  def show
    @page_title = "Reading Message: #{@message.title}"
    @message.read_now if current_user == @message.destinatary
  end

  def new
    @page_title = t('application_layout.title.new_message')
    @message = Message.new
  end

  def create
    @message                      = Message.new(message_params)
    @message.author               = current_user
    @message.destinatary_nickname = params[:message][:destinatary_nickname]

    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_url }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.archive_now
    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end

  def mass_action
    return unless params[:message_checkboxes].present?

    params[:message_checkboxes].each do |message_id|
      message = Message.find(message_id)

      case params[:commit]
      when t('message.view.message_list.button.mark_read')
        message.read_now
      when t('message.view.message_list.button.archive')
        message.archive_now
      else
        return
      end
    end
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def set_messages
      @messages_unread = Message.current_user_unread(current_user)
    end

    def message_params
      params.require(:message).permit(:title, :content, :author_id, :destinatary_id)
    end

    def is_owner
      redirect_to messages_path unless current_user == @message.destinatary or
        current_user == @message.author
    end
end
