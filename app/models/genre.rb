class Genre < ApplicationRecord
  acts_as_paranoid

  validates :genre_name, presence: true
end
