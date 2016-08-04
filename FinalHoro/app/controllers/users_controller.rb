class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
  end
  def index
    @users = User.all
  end
  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:firstname, :lastname, :altername1, :altername2,:altername3,
                                  :timeofbirthhour,:timeofbirthmin,:date, :month,
                                  :year,:birthdate,:age,:moonyear,:phone,:lineid,:email,
                                  :username,  :password, :password_confirmation, :memberid )
    end

end
