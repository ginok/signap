module Signap::SecurePassword
  extend ActiveSupport::Concern

  module ClassMethods
    def has_secure_password
      require 'bcrypt'

      attr_reader :password
      field :password_digest, type: String

      validates_confirmation_of :password
      validates_presence_of :password_digest, on: :update

      if respond_to?(:attributes_protected_by_default)
        def self.attributes_protected_by_default
          super + ['password_digest']
        end
      end
    end
  end

  def authenticate(unencrypted_password)
    return false if password_digest.blank?
    if BCrypt::Password.new(password_digest) == unencrypted_password
      self
    else
      false
    end
  end

  def password=(unencrypted_password)
    @password = unencrypted_password
    unless unencrypted_password.blank?
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end
end
