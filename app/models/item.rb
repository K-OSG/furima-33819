class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :fee
  belongs_to :perfecture
  belongs_to :day
  belongs_to :user
  has_one :consumer
  has_one_attached :image

  validates :price, inclusion: { in: 300..9_999_999 }, format: { with: /\A[0-9]+\z/ }, numericality: true, allow_blank: true
  with_options presence: true do
    validates :name
    validates :description
    validates :price
    validates :user
    validates :image
      with_options numericality: { other_than: 1 } do
        validates :category_id
        validates :status_id
        validates :fee_id
        validates :perfecture_id
        validates :day_id
     end
  end

end