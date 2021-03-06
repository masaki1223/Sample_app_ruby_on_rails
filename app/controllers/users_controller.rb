class UsersController < ApplicationController
  #redirect to root unless user is logged in
  before_action :logged_in_user,only:[:index,:edit,:update]
  #redirect to root unless user is correct user
  before_action :correct_user,only:[:edit,:update]
  before_action :admin_user, only:[:destroy]

  def show
    @user=User.find(params[:id])
  end
  def index
    @users = User.paginate(page: params[:page], per_page: 10)  
  end

  def new
    @user=User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success]="Welcome to the Sample App!"
      redirect_to user_url(@user)
    else
      flash[:danger]="Oops!Something went wrong!"
      render 'new'
    end
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success]="Profile updated"
      redirect_to @user
    else
      render'edit'
      end
    end

    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User is successfully deleted"
      redirect_to users_url
    end

  private

    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger]="Please log in."
        redirect_to login_url
      end
    end
    def correct_user
      @user = User.find(params[:id])
      flash[:danger]="Please log in with correct account."
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.try(:admin)
    end
end

