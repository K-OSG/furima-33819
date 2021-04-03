class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :item_find, only: [:show, :edit, :update, :destroy]
  before_action :return_root, only: [:edit, :update, :destroy]

  def index
    @items = Item.all.order( "created_at DESC" )
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
     if @item.save
      redirect_to root_path 
     else
      render :new
     end
  end

  def show
  end

  def edit
    if @item.consumer.present?
      redirect_to root_path
    end
  end

  def update
     if @item.update(item_params)
      redirect_to item_path(@item.id)
     else
      render :edit
     end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :category_id, :status_id, :fee_id, :perfecture_id, :day_id, :price, :image).merge(user_id: current_user.id)
  end

  def item_find
    @item = Item.find(params[:id])
  end
  
  def return_root
    unless @item.user.id == current_user.id
      redirect_to root_path if @item.consumer.present?
    end
  end

end