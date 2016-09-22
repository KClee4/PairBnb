class UsersController < Clearance::UsersController
  include UsersHelper

	def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    redirect_to root_path if @user != current_user
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
  
      redirect_to @user, notice: "Successful updated!"
    else
      render "edit"
    end

    def booking_email

    end
  end

  private
  	def user_params
  	    params.require(:user).permit(:firstname, :lastname, :email, :password, :birthday, :profile_image)
  	end
end
