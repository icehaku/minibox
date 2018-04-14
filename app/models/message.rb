class Message < ApplicationRecord
  has_one :author,      class_name: "User"
  has_one :destinatary, class_name: "User"
end
