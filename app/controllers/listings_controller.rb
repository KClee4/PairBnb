class ListingsController < ApplicationController
  before_action :require_login, except: [:show, :index]
  before_action :find_listing, only: [:show, :edit, :update, :destroy]

  def index

    if filter_params.any?
      if filter_params[:min].present? && filter_params[:max].present?
        @listings = Listing.price_range(filter_params[:min],filter_params[:max])
      elsif filter_params[:min].present? && !filter_params[:max].present?
        @listings = Listing.min_price(filter_params[:min])
      elsif !filter_params[:min].present? && filter_params[:max].present?
        @listings = Listing.max_price(filter_params[:max])
      end
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
    @listing = current_user.listings.build(listing_params)

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
    @listing.destroy
    redirect_to listings_path
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :description, :price, :tag_list, {listing_images: []})
  end

  def find_listing
    @listing = Listing.find(params[:id])
  end

  def filter_params
    params.permit(:min, :max).reject { |x, y| y.empty? }
    
  end

end
