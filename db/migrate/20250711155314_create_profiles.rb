class CreateProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :profiles do |t|
      t.string :racket_model
      t.string :history
      t.string :play_style
      t.string :level
      t.integer :generation
      t.integer :gender
      t.text :body

      #usersテーブルと1対1の関係のため記載
      t.belongs_to :user, index:{unique: true}, foreign_key: true

      t.timestamps
    end
  end
end
