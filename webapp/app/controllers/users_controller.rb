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
    @users = User.all
    if params[:search]
      @users = User.search(params[:search],params[:search_from]).order("created_at DESC")
    else
      @users = User.all.order("created_at DESC")
    end
    respond_to do |format|
    format.html
    format.csv { send_data @users.as_csv.encode("UTF-8"), filename: "users-#{Date.today}.csv" }

    end
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if verify_recaptcha(model: @user) && @user.save
        format.html { redirect_to @user, notice: 'Welcome to FinalHoro!' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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
