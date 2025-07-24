class Profile < ApplicationRecord
  belongs_to :user

  enum generation: {
    under_10: 0,
    teens: 1,
    twenties: 2,
    thirties: 3,
    forties: 4,
    fifties: 5,
    sixties: 6,
    over_70: 7,
  }

  enum  gender: { male: 1, female: 2, other: 3 }

end
