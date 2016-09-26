class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing

  validates_presence_of :begin_date, :end_date, :guest_count
  validates_numericality_of :guest_count, :less_than_or_equal_to => 15
  validate :available_date
  validate :selected_date

  def total_nights(begin_date, end_date)
    @total_nights = (end_date - begin_date)
  end

  def total_price(price_per_night, total_nights)
    @total_price = (total_nights * price_per_night)
  end

  private

  def available_date
    if begin_date && end_date
    	errors.add(:end_date, "must be after start date") unless end_date > begin_date
      errors.add(:begin_date, "must not before today") unless begin_date >= Date.today
    end
  end

  def selected_date
    if begin_date && end_date
    	reservations = listing.reservations
    	reservations.each do |x|
    		if (begin_date..end_date).overlaps?(x.begin_date..x.end_date)
    			errors.add(:date, "is overlapped") 
    			break
    		end
    	end
    end
  end

end
