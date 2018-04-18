module MessagesHelper
  def is_read_class(message)
    message.read ? "normal_message" : "new_message"
  end

  def is_read_icon(message)
    unless message.read
      content_tag(:i, "", class: ["fa", "fa-envelope"])
    end
  end

  def is_important_icon(message)
    if message.important
      content_tag(:i, "", class: ["fa", "fa-star"])
    end
  end

  def new_messages_badge(messages)
    return unless messages.present?
    content_tag(:span, messages.count, class: ["label",  "label-danger", "pull-right"])
  end
end
