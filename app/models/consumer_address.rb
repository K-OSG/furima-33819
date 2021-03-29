class ConsumerAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postcode, :perfecture_id, :city, :address, :bulding, :phone_number, :consumer_id, :token

  validates :phone_number, numericality: {only_integer: true, message: "is invalid"}, allow_blank: true
  validates :postcode, format: {with: /\A\d{3}[-]\d{4}\z/}, allow_blank: true
  with_options presence:true do
    validates :postcode
    validates :perfecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address
    validates :item_id
    validates :user_id
    validates :consumer_id
    validates :phone_number
    validates :token
  end

  def save
    consumer = Consumer.create(item_id: item_id, user_id: user_id)
    binding.pry
    Address.create(postcode: postcode, perfecture_id: perfecture_id, city: city, address: address, bulding: bulding, phone_number: phone_number, consumer_id: consumer.id)
  end

end