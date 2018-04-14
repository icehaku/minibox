class User < ApplicationRecord
  validates_presence_of   :name, :nickname
  validates_uniqueness_of :nickname

  devise :database_authenticatable, :registerable, :recoverable, :validatable
end
