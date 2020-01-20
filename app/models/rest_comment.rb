class RestComment < ApplicationRecord
    belongs_to :user
    belongs_to :restaurant

    validates :comment, presence: true, length: { maximum: 500 }
end
