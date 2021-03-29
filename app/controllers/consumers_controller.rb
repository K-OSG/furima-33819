class ConsumersController < ApplicationController
  before_action :authenticate_user!, only:[:index, :create]
  before_action :index_item, only:[:index, :create]
  before_action :soldout_item_return, only: :index
  def index
    @consumer_address = ConsumerAddress.new
    if @item.user == current_user
      redirect_to root_path
    end
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
    params.require(:consumer_address).permit(:postcode, :perfecture_id, :city, :address, :phone_number).merge(user_id: current_user.id, token: params[:token], consumer_id: current_user.id, item_id: params[:item_id])
  end

  def index_item
    @item = Item.find(params[:item_id])
  end

  def soldout_item_return
    redirect_to root_path if @item.consumer.present?
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