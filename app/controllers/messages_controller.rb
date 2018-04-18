class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: [:show, :destroy, :make_important]
  before_action :set_messages, only: [:index, :new, :show,
    :sent_box, :archived_box, :important_box]

  # GET /messages
  # GET /messages.json
  def index
    @page_title = "Inbox"
    @messages = Message.current_user_inbox(current_user)
  end

  def make_important
    @message.important_now
    redirect_to messages_url
  end

  def sent_box
    @page_title = "Sent Messages"
    @messages = Message.current_user_sent(current_user)
  end

  def important_box
    @page_title = "Important Messages"
    @messages = Message.current_user_important(current_user)
  end

  def archived_box
    @page_title = "Archived Messages"
    @messages = Message.current_user_archived(current_user)
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @page_title = "Reading Message: #{@message.title}"
    @message.read_now if current_user == @message.destinatary
  end

  # GET /messages/new
  def new
    @page_title = "New Message"
    @message = Message.new
  end

  # POST /messages
  # POST /messages.json
  def create
    @message                      = Message.new(message_params)
    @message.author               = current_user
    @message.destinatary_nickname = params[:message][:destinatary_nickname]

    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_url, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.archive_now
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def mass_action
    return unless params[:message_checkboxes].present?

    params[:message_checkboxes].each do |message_id|
      message = Message.find(message_id)

      case params[:commit]
      when "Mark as Read"
        message.read_now
      when "Archive"
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
end
