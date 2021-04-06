class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  has_many :consumers

    with_options allow_blank: true do
      with_options format:{ with: /\A[ぁ-んァ-ヶ一-龥々]+\z/} do
        validates :fristname
        validates :lastname
      end
      with_options format:{with:/\A[ァ-ヶー－]+\z/} do
        validates :fristname_kana
        validates :lastname_kana
      end
      with_options format:{with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}/} do
      validates :password
      end
    end
    with_options presence: true do
      validates :password
      validates :nickname
      validates :fristname
      validates :lastname
      validates :fristname_kana
      validates :lastname_kana
      validates :birth_date
    end
end