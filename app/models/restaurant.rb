class Restaurant < ApplicationRecord
  acts_as_taggable #tag用記述
  has_many :rest_comments, dependent: :destroy
  has_many :wants, dependent: :destroy
  def wanted_by?(user)
    wants.where(user_id: user.id).exists?
  end
  has_many :repeats, dependent: :destroy
  def repeated_by?(user)
    repeats.where(user_id: user.id).exists?
  end
end