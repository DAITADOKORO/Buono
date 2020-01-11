class Genre < ApplicationRecord
  has_many :restaurants
  acts_as_paranoid

  validates :genre_name, presence: true
end
