class ListingsController < ApplicationController
  before_action :require_login, except: [:show, :index]
  before_action :find_listing, only: [:show, :edit, :update, :destroy]

  def index
    byebug
    if filter_params.any?
      @listings = Listing.filter(filter_params)
    else
      @listings = Listing.all
    end

  end

  def show
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)

    if @listing.save
      redirect_to @listing, notice: "Listing successfully created"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      redirect_to @listing, notice: "Successfully updated listing"
    else
      render 'edit'
    end
  end


  def destroy
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :description, :price)
  end

  def find_listing
    @listing = Listing.find(params[:id])
  end

  def filter_params
    params.permit(:min, :max)
    
  end

end
