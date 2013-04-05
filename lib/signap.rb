require "signap/engine"

module Signap
  mattr_accessor :user_class

  def self.user_class
    @@user_class.constantize
  end
end
