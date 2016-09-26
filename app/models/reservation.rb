class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing

  validates_presence_of :begin_date, :end_date, :guest_count
  validates_numericality_of :guest_count, :less_than_or_equal_to => 15
  validate :available_date, on: :create
  validate :selected_date, on: :create

  def full_price
    listing.price * ((begin_date..end_date).count - 1)
  end

  def pay!
    update(payment: true)
  end

  def paid?
    payment == true
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
