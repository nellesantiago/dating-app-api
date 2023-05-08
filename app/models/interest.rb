class Interest < ApplicationRecord
  belongs_to :user

  enum gender: { men: 0, women: 1, nonbinary_people: 2 }
end
