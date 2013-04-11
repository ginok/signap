module Signap
  module Confirmable
    extend ActiveSupport::Concern

    included do
      include Signap::SecurePassword
      field :confirmation_token, type: String
      field :confirmed_at, type: DateTime

      before_create :generate_confirmation_token, if: :confirmation_required?
    end

    module ClassMethods
      def confirm_by_token(token)
        confirmable = self.find_by(:confirmation_token, token)
        confirmable.confirm!
        confirmable
      end
    end

    def confirm!
      self.confirmation_token = nil
      self.confirmed_at = Time.now
      save
    end

    def confirmed?
      !!confirmed_at
    end

    def only_if_unconfirmed
      yield unless confirmed?
    end

    def has_no_password?
      self.password_digest.blank?
    end

    protected
    def generate_confirmation_token
      self.confirmation_token = Signap.generate_token
    end

    def generate_confirmation_token!
      self.generate_confirmation_token; save
    end



    def confirmation_required?
      !confirmed?
    end
  end
end
