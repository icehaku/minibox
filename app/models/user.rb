class User < ApplicationRecord
  has_many :sent_messages,     class_name: 'Message', foreign_key: 'author_id'
  has_many :received_messages, class_name: 'Message', foreign_key: 'destinatary_id'

  validates_presence_of   :name, :nickname
  validates_uniqueness_of :nickname

  devise :database_authenticatable, :registerable, :recoverable, :validatable
end
