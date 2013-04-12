module Signap
  class ConfirmationsController < ApplicationController
    def show
      if @confirmable = user_class.find_unconfirmed_confirmable(params[:confirmation_token])
        do_show
      else
        redirect_to new_confirmation_path
      end
    end

    def update
      if @confirmable = user_class.find_unconfirmed_confirmable(params[:confirmation_token])
        @confirmable.assign_attributes(confirm_params)
        if @confirmable.valid?
          do_confirm
        else
          do_show
        end
      else
        redirect_to new_confirmation_path
      end
    end

    protected
    def do_show
      @confirmation_token = @confirmable.confirmation_token
      render :show
    end

    def do_confirm
      @confirmable.confirm!
      login_and_redirect(@confirmable)
    end

    private
    def confirm_params
      params.require(:user).permit(*additional_attributes)
    end
  end
end
