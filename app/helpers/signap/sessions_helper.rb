module Signap
  module SessionsHelper
    def current_user
      return nil if self.session_user_id.nil?
      @_current_user ||= Signap.user_class.find(self.session_user_id)
    end

    def logged_in?
      !current_user.nil?
    end

    def login(user)
      self.session_user_id = user.to_param
    end

    def logout
      self.session_user_id = nil
    end

    protected
    def session_user_id=(id)
      session[:signap_user_id] = id
    end

    def session_user_id
      session[:signap_user_id]
    end

    def require_login
      unless logged_in?
        redirect_to :login
      end
    end
  end
end
