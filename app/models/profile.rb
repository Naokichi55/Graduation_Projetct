class Profile < ApplicationRecord
  def change
		create_table :profiles do |t|
    t.belongs_to :users, index: {unique: true}, foreign_key :tre
    t.string :racket_name
    t.string :history
    t.string :play_style
    t.string :level
		t.string :generation
		t.string :gender
		t.text :body

	end
  end


end
