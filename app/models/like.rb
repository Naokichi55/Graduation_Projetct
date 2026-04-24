class Like < ApplicationRecord
  belongs_to :user
	belongs_to :racket

  validate :user_id, uniqueness: { scope: :racket_id }
end
