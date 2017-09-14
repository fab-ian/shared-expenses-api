module V1
  class ItemsController < ApplicationController
    before_action :set_user, except: %i[new edit]
    before_action :set_item, only: %i[show update destroy]

    def index
      @items = @user.items.page(params[:page])
      json_response(@items)
    end

    def show
      json_response(@item)
    end

    def create
      @item = @user.items.create!(item_params)
      json_response(@item, :created)
    end

    def update
      @item.update(item_params)
      head :no_content
    end

    def destroy
      @item.destroy
      head :no_content
    end

    private

    def item_params
      params.permit(:name, :description)
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_item
      @item = @user.items.find(params[:id]) if @user
    end
  end
end
