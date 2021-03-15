require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '商品出品可能時' do
      it '全てのデータが正しく存在すれば出品可能' do
        expect(@item).to be_valid
      end

      it 'priceが¥300なら出品可能' do
        @item.price = 300
        expect(@item).to be_valid
      end
      it 'priceが¥9,999,999な出品可' do
        @item.price = 9_999_999
        expect(@item).to be_valid
      end
      it 'priceが半角数字なら出品可' do
        @item.price = 300
        expect(@item).to be_valid
      end
    end

    context '商品出品不可時' do
      it 'imageがないと出品不可' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameがないと出品不可' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'descriptionがないと出品不可' do
        @item.description = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'category_idがないと出品不可' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end
      it 'status_idがないと出品不可' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Status must be other than 1')
      end
      it 'fee_idがないと出品不可' do
        @item.fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Fee must be other than 1')
      end
      it 'perfecture_idがないと出品不可' do
        @item.perfecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Perfecture must be other than 1')
      end
      it 'day_idがないと出品不可' do
        @item.day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Day must be other than 1')
      end
      it 'priceがないと出品不可' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが¥300以下だと出品不可' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not included in the list')
      end
      it 'priceが¥9,999,999以上だと出品不可' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not included in the list')
      end
      it 'priceが全角数字だと出品不可' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not included in the list')
      end
      it "priceが半角英数混合では出品不可" do
        @item.price = "300aaa"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it "priceが半角英語では出品不可" do
        @item.price = "aaabbbccc"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not included in the list")
      end
    end
  end
end
