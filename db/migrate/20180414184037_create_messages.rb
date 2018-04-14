class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :author
      t.references :destinatary

      t.timestamps
    end

    add_foreign_key :messages, :users, column: :author_id, primary_key: :id
    add_foreign_key :messages, :users, column: :destinatary_id, primary_key: :id
  end
end
