class Restaurant < ApplicationRecord
  belongs_to :genre
  belongs_to :admin
  belongs_to :user
end
