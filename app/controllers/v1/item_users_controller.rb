module V1
  class ItemUsersController < ApplicationController
    before_action :set_item, only: %i(index create)
    before_action :set_user, only: :create

    def index
      json_response(ItemUser.where(item: @item))
    end

    def create
      @item_user = ItemUser.create!(item: @item, user: @user)
      json_response(@item_user, :created)
    end

    def destroy
      ItemUser.find(params[:id]).destroy
      head :no_content
    end

    private

    def set_item
      @item = Item.find_by!(id: params[:item_id])
    end

    def set_user
      @user = User.find_by!(id: params[:user_id])
    end
  end
end
