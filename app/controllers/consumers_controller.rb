class ConsumersController < ApplicationController
  before_action :authenticate_user!, only:[:index, :create]
  before_action :index_item, only:[:index, :create]
  before_action :soldout_item_return, only: [:index, :create]
  def index
    @consumer_address = ConsumerAddress.new
  end

  def create
    @consumer_address = ConsumerAddress.new(consumer_params)
    if @consumer_address.valid?
      pay_item
      @consumer_address.save
      redirect_to root_path
    else
      render :index
    end
  end
  
  private
  def consumer_params
    params.require(:consumer_address).permit(:postcode, :perfecture_id, :city, :address, :phone_number).merge(user_id: current_user.id, token: params[:token], item_id: params[:item_id])
  end

  def index_item
    @item = Item.find(params[:item_id])
  end

  def soldout_item_return
    if @item.user == current_user || @item.consumer.present?
    redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: consumer_params[:token],
      currency: 'jpy'
    )
  end
end