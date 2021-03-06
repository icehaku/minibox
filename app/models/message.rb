class Message < ApplicationRecord
  belongs_to :author,      class_name: "User", optional: true
  belongs_to :destinatary, class_name: "User", optional: true

  attr_accessor :destinatary_nickname

  validates_presence_of :title, :content
  validate :destinatary_exist?, on: :create

  def destinatary_exist?
    destinatary = User.find_by_nickname(destinatary_nickname)
    destinatary.present? ? self.destinatary_id = destinatary.id :
      errors.add(:destinatary_nickname, "can't be found!")
  end

  def read_now
    return if self.read
    self.update_attributes(read: true, read_date: DateTime.now)
    ActionCable.server.broadcast 'messages',
      status: 'saved', id: id, html: render_message
  end

  def important_now
    self.toggle(:important).save
    ActionCable.server.broadcast 'messages',
      status: 'saved', id: id, html: render_message
  end

  def archive_now
    self.update_attributes(archived: true, archive_date: DateTime.now)
    ActionCable.server.broadcast 'messages', status: 'deleted', id: id
  end

  def unarchive_now
    self.update_attributes(archived: false, archive_date: nil)
  end

  scope :current_user_inbox, lambda { |current_user|
    where(destinatary: current_user, archived: false).order(
      'created_at desc').includes(:author)
  }

  scope :current_user_archived, lambda { |current_user|
    where(destinatary: current_user, archived: true).order(
      'created_at desc').includes(:author)
  }

  scope :current_user_sent, lambda { |current_user|
    where(author: current_user).order(
      'created_at desc').includes(:destinatary)
  }

  scope :current_user_important, lambda { |current_user|
    where(destinatary: current_user, important: true).order(
      'created_at desc')
  }

  scope :current_user_unread, lambda { |current_user|
    where(destinatary: current_user, read: false, archived: false)
  }

  private

  def render_message
    ApplicationController.render(partial: 'messages/message_line',
      locals: { message: self })
  end
end
