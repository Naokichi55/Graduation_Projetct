class CreateLikes < ActiveRecord::Migration[7.2]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :racket_id

      t.timestamps
    end
    add_index :likes, %i[user_id racket_id], unique: true
  end
end
