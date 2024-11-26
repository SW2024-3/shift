class Admin::UserController < ApplicationController
    def index
        @users = User.all
    end
    
    def show
        @users = User.all
    end
    def edit
        @user = User.find(params[:id])
    end
    def update
        user = User.find(params[:id])
        if user.update(admin: params[:admin])
          redirect_to admin_users_path, notice: "#{user.name}の権限を更新しました。"
        else
          redirect_to admin_users_path, alert: "権限の更新に失敗しました。"
        end
    end
end
