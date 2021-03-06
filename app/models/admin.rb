class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  acts_as_paranoid

  validates :email,uniqueness: true, presence: true
  validates :name, presence: true
  validates :name_kana, presence: true,format: {with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください'}

end
