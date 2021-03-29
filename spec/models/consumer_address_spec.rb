require 'rails_helper'
  
RSpec.describe ConsumerAddress, type: :model do
  describe "商品購入機能" do
    before do
      @consumer_address = FactoryBot.build(:consumer_address)
    end
  
    context '商品購入可能時' do
      it '全てのデータが正しく存在すれば出品可能' do
        expect(@consumer_address).to be_valid
      end
    end
    
    context '商品購入不可時' do
      it 'tokenがない(クレジット情報)がないと購入不可' do
        @consumer_address.token = nil
        @consumer_address.valid?
        expect(@consumer_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'postcodeがないがないと購入不可' do
        @consumer_address.postcode = nil
        @consumer_address.valid?
        expect(@consumer_address.errors.full_messages).to include("Postcode can't be blank")
      end
    
      it 'postcodeに-(ハイフン)がないと購入不可' do
        @consumer_address.postcode = "1234567"
        @consumer_address.valid?
        expect(@consumer_address.errors.full_messages).to include("Postcode is invalid")
      end
    
      it 'perfecture_idを選択しないと購入不可' do
        @consumer_address.perfecture_id = "1"
        @consumer_address.valid?
        expect(@consumer_address.errors.full_messages).to include("Perfecture can't be blank")
      end
    
      it 'cityがないがないと購入不可' do
        @consumer_address.city = nil
        @consumer_address.valid?
        expect(@consumer_address.errors.full_messages).to include("City can't be blank")
      end
    
      it 'addressがないがないと購入不可' do
        @consumer_address.address = nil
        @consumer_address.valid?
        expect(@consumer_address.errors.full_messages).to include("Address can't be blank")
      end
    
      it 'phone_numberがないがないと購入不可' do
        @consumer_address.phone_number = nil
        @consumer_address.valid?
        expect(@consumer_address.errors.full_messages).to include("Phone number can't be blank")
      end
    
      it 'phone_numberが半角数字以外では購入不可' do
        @consumer_address.phone_number = "０９０１２３４５６７８"
        @consumer_address.valid?
        expect(@consumer_address.errors.full_messages).to include("Phone number is invalid")
      end
    
    end
  end  
end
  
  