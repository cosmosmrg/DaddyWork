class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update,:index,:show, :destroy]
  before_action :correct_user,   only: [:edit, :update,:show]
  before_action :admin_user,     only: [:index, :destroy]
  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
  end
  def index
    @users = User.paginate(page: params[:page])
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

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
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
      redirect_to(user_path(current_user)) unless current_user?(@user) || current_user.admin?
    end
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
