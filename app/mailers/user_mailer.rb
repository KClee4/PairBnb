class UserMailer < ApplicationMailer
	default from :

	def wekcome_email(user)
		@user = user
		@url = 'http://localhost:3000'
		mail(to: @user.email, subject: 'Welcome to PairBnB')
end
