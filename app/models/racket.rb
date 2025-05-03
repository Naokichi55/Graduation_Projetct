class Racket < ApplicationRecord
  belongs_to :user

  validates :product_name, presence: true, length: { maximum: 255 }
  validates :maker_name, presence: true, length: { maximum: 255 }
  validates :face_size, inclusion: { in: 0...100 }
  validates :main_string, length: { maximum: 255 }
  validates :cross_string, length: { maximum: 255 }
  validates :main_string_tension, length: { maximum: 255 }
  validates :cross_string_tension, inclusion: { in: 0...100 }
  validates :grip_size, inclusion: { in: 0...100 }
  validates :grip_tape, length: { maximum: 255 }
  validates :body, length: { maximum: 65_535 }
end
