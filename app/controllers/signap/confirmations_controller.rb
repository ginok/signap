module Signap
  class ConfirmationsController < ApplicationController
    def show
      with_unconfirmed_confirmable do
        if @confirmable.has_no_password?
          do_show
        else
          do_confirm
        end
      end
      if !@confirmable.errors.empty?
        render :new
      end
    end

    def confirm
      with_unconfirmed_confirmable do
        @confirmable.assign_attributes(confirm_params)
        if @confirmable.valid?
          do_confirm
        else
          do_show
        end
      end
    end

    protected
    def with_unconfirmed_confirmable
      @confirmable = user_class.find_by(
        confirmation_token: params[:confirmation_token])
      if !@confirmable.new_record?
        @confirmable.only_if_unconfirmed { yield }
      end
    end

    def do_show
      @confirmation_token = params[:confirmation_token]
      render :show
    end

    def do_confirm
      @confirmable.confirm!
      #login_and_redirect
      redirect_to "/"
    end

    private
    def confirm_params
      params.require(:user).permit(:password)
    end
  end
end
