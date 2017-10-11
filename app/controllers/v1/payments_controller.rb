module V1
  class PaymentsController < ApplicationController
    before_action :find_payment, only: %i(update destroy)

    def create
      @payment = Payment.create!(payment_params)
      json_response(@payment, :created)      
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
      params.permit(:name, :description, :item_id)
    end

    def find_payment
      @payment = Payment.find(params[:id])
    end
  end
end
