module Signap
  class SessionsController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]

    def new
    end

    def create
      if @user = user_class.authenticate(session_params[:email], session_params[:password])
        login_and_redirect(@user, page_after_login)
      else
        login_failed
      end
    end

    def destroy
      logout
      redirect_to page_after_logout
    end

    private
    def session_params
      params.require(:session).permit(:email, :password)
    end

    def page_after_login
      Signap.configuration.redirect_url_after_login
    end

    def page_after_logout
      login_path
    end

    def login_failed
      render :new, status: :unauthorized
    end
  end
end
