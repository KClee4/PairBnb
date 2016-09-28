class ListingsController < ApplicationController
  before_action :require_login, except: [:show, :index]
  before_action :find_listing, only: [:show, :edit, :update, :destroy]

  def index
    @listings = Listing.order('created_at DESC')
  end

  def search
    @listings = Listing.search params[:search], fields: [:title], match: :word_start
    
    render 'index'
  end

  def filter
    @listings = Listing.where(id: params[:listings].gsub!("[","").gsub("]","").split(', '))
    @listings = @listings.filter_by_range(filter_params)
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

  def autocomplete
    render json: Listing.search(params[:query], 
      {fields: [:title],
        limit: 10, match: :word_start,
        misspellings: {below: 5}}).map {|t| {"title": t.title}}

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
