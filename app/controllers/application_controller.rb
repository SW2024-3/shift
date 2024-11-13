class ApplicationController < ActionController::Base
    helper_method :current_user
    private
    def current_user
        if session[:login_uname]
            User.find_by(uname: session[:login_uname])
        end
    end
end
