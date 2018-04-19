class MessageSerializer < ActiveModel::Serializer
  attributes :content, :author, :destinatary, :title,
    :archived, :archive_date, :read, :read_date, :important
end
