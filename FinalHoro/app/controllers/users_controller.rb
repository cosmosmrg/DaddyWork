class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update,:index,:show]
  before_action :correct_user,   only: [:edit, :update,:show]
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
      flash[:success] = "Welcome to FinalHoro!"
      redirect_to @user
    else
      render 'new'
    end
  end
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end




  private

    def user_params
      params.require(:user).permit(:firstname, :lastname, :altername1, :altername2,:altername3,
                                  :timeofbirthhour,:timeofbirthmin,:date, :month,
                                  :year,:birthdate,:age,:moonyear,:phone,:lineid,:email,
                                  :username,  :password, :password_confirmation, :memberid )
    end

    def logged_in_user
        unless logged_in?
          flash[:danger] = "กรุณาล็อคอินเข้าสู่ระบบ"
          redirect_to login_url
        end
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to(user_path(current_user)) unless current_user?(@user)
    end

end
