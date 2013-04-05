module Signap
  class RegisterablesController < ApplicationController
    def new
      @registerable = Registerable.new
    end
  end
end
