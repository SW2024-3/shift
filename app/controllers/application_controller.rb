class ApplicationController < ActionController::Base
    helper_method :current_user
    private
    def current_user
        if session[:login_uid]
            User.find_by(uname: session[:login_name])
        end
    end
end
