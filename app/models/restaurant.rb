class Restaurant < ApplicationRecord
  has_many :rest_comments, dependent: :destroy
end