module MessagesHelper
  def was_read?(message)
    message.read ? "normal_message" : "new_message"
  end
end
