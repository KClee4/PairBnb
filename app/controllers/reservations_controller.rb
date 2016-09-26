class ReservationsController < ApplicationController
	before_action :require_login

	def new
		@reservation = Reservation.new
	end

  
  def create
  	@listing = Listing.find(params[:listing_id])
  	@reservation = current_user.reservations.build(reserve_params)
  	@reservation.listing = @listing
    respond_to do |format|
     if @reservation.save
      ReservationMailer.reservation_email(@reservation.listing.user, @reservation.user, @reservation.id).deliver_later

      format.html { redirect_to("/reservations/#{@reservation.id}/transactions/new", notice: "Successfully reserved!")}
    else
      format.html { render 'new' }
    end
    end
  end

  def index
  	@reservations = current_user.reservations
  end

  private

  def reserve_params
  	params.require(:reservation).permit(:begin_date, :end_date, :guest_count)
  end
end
