module Signap
  class RegisterablesController < ApplicationController
    def new
      @registerable = Signap.user_class.new
    end

    def create
      @registerable = Signap.user_class.new(registerable_params)
      if @registerable.save
        redirect_to page_after_sign_up, notice: "Success!!"
      else
        render :new
      end
    end

    private
    def registerable_params
      params.require(Signap.user_class.to_s.downcase).permit(:email, :password)
    end

    def page_after_sign_up
      new_registerable_path
    end
  end
end
