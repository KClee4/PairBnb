class ReservationMailer < ApplicationMailer
	default from: 'pairbnb1@gmail.com'

	def reservation_email(host, guest, reservation_id)
		@host = host
		@guest = guest
		@reservation_id = reservation_id
		@url = 'http://localhost:3000'
		mail(to: @host.email, subject: 'Reservation')
	end
end
