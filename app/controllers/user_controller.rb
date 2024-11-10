class UserController < ApplicationController
  def index
    @user = User.all
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to shift_index_path, notice: 'ユーザー情報が更新されました'
    else
      render :edit, status: 422
    end
  end
  
  def new
    @user = User.new
  end

  def create
    #signup_password = BCrypt::Password.create(params[:user][:pass])
    u = User.new(uid: params[:user][:uid], password: params[:user][:password],password: params[:user][:password_confirmation])
    if params[:user][:password] != params[:user][:password_confirmation]
      render "error", status: 422
    else
      u.save
      redirect_to users_path
    end
    
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
  end
  
  private
  def user_params
    params.require(:user).permit(:uid, :uname, :name, :color, :money)
  end
end
