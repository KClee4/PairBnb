class TransactionsController < ApplicationController
  before_action :require_login
  
  def new
    gon.client_token = generate_client_token

    @reservation = Reservation.find(params[:reservation_id])
  end

  def create
    @reservation = Reservation.find(params[:reservation_id])

    @result = Braintree::Transaction.sale(
              amount: @reservation.full_price,
              payment_method_nonce: params[:payment_method_nonce])
    if @result.success?
      @reservation.pay!
      redirect_to @reservation.listing, notice: "Congraulations! Your transaction has been successfully!"
    else
      flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
      gon.client_token = generate_client_token
      render :new
    end
  end

  private

  def generate_client_token
    Braintree::ClientToken.generate
  end
end
