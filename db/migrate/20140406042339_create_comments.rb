class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :meme_id
      t.text :body
      t.integer :hearts

      t.timestamps
    end
  end
end
