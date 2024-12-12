class TopController < ApplicationController
  def main
    if session[:login_uname]
      user = User.find_by(uname: session[:login_uname])
      if user&.admin
        redirect_to admin_user_index_path
      else
        redirect_to shift_index_path
      end
    else
      render "login"
    end
  end
    
    def login
        user = User.find_by(uname: params[:uname])
        if user and BCrypt::Password.new(user.password_digest) == params[:pass]
            session[:login_uname] = params[:uname]
            redirect_to top_main_path
        else
            render "error", status: 422
        end
    end
    
    def logout
        session.delete(:login_uname)
        redirect_to root_path
    end
end