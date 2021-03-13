class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  has_many :consumers

  validates :password, format:{with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{7,}/}
  with_options presence: true do
    validates :nickname
    with_options format:{ with: /\A[ぁ-んァ-ヶ一-龥々]+\z/} do
      validates :fristname
      validates :lastname
    end
    with_options format:{with:/\A[ァ-ヶー－]+\z/} do
      validates :fristname_kana
      validates :lastname_kana
    end
    validates :birth_date
  end
end