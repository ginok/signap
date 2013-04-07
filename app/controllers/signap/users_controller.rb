module Signap
  class UsersController < ApplicationController
    def new
      @user = user_class.new
    end

    def create
      @user = user_class.new(user_params)
      #debugger
      if @user.save
        redirect_to page_after_sign_up, notice: "Success!!"
      else
        render :new
      end
    end

    private
    def user_params
      params.require(singular_name).permit(:email, :password)
    end

    def page_after_sign_up
      new_user_path
    end
  end
end
