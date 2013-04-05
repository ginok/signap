module Signap
  class RegisterablesController < ApplicationController
    def new
      @registerable = Registerable.new
    end

    def create
      @registerable = Registerable.new(registerable_params)
      if @registerable.save
        redirect_to page_after_sign_up, notice: "Success!!"
      else
        render :new
      end
    end

    private
    def registerable_params
      params.require(:registerable).permit(:email, :password)
    end

    def page_after_sign_up
      new_registerable_path
    end
  end
end
