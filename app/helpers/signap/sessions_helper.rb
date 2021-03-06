module Signap
  module SessionsHelper
    def current_user
      return nil if self.session_user_id.nil?
      @_current_user ||= Signap.configuration.user_model.find(self.session_user_id)
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

    def login_and_redirect(user, url=nil)
      login(user)
      redirect_to (url || Signap.configuration.redirect_url_after_login)
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
        redirect_to signap.login_path
      end
    end
  end
end
