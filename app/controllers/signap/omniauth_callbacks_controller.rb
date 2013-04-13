module Signap
  class OmniauthCallbacksController < ApplicationController
    def callback
      omniauthable =
        user_class.find_or_create_omniauthable(request[:provider], auth_hash)
      if omniauthable.confirmation_required?
        redirect_to confirmation_path(confirmation_token: omniauthable.confirmation_token)
      else
        login_and_redirect(omniauthable)
      end
    end

    protected
    def auth_hash
      request.env['omniauth.auth']
    end
  end
end
