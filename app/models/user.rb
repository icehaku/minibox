class User < ApplicationRecord
  has_many :sent_messages,     class_name: 'Message', foreign_key: 'author_id'
  has_many :received_messages, class_name: 'Message', foreign_key: 'destinatary_id'

  validates_presence_of   :name, :nickname
  validates_uniqueness_of :nickname
  validates :nickname, format: { with: /\A[a-zA-Z0-9]*\z/,
    message: "can't special characters, only letters and numbers." }

  devise :database_authenticatable, :registerable, :recoverable, :validatable
end
