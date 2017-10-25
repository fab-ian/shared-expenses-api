module V1
  class PaymentsController < ApplicationController
    before_action :find_payment, only: %i(update destroy)
    before_action :find_item, only: :create

    def create
      Payment.create!(payment_params)
      json_response(@item, :created)      
    end

    def update
      @payment.update(payment_params)
      head :no_content
    end

    def destroy
      @payment.destroy
      head :no_content
    end

    private

    def payment_params
      params.require(:payment).permit(:name, :description, :item_id, :amount)
    end

    def find_payment
      @payment = Payment.find(params[:id])
    end

    def find_item
      @item = Item.find(params[:item_id])
    end
  end
end
