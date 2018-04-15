class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text       :content
      t.references :author
      t.references :destinatary
      t.string     :title
      t.boolean    :archived, default: false
      t.datetime   :archive_date
      t.boolean    :read, default: false
      t.datetime   :read_date
      t.timestamps
    end

    add_foreign_key :messages, :users, column: :author_id, primary_key: :id
    add_foreign_key :messages, :users, column: :destinatary_id, primary_key: :id
  end
end
