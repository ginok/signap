module Signap
  module Confirmable
    extend ActiveSupport::Concern

    included do
      include Signap::SecurePassword
      field :confirmation_token, type: String
      field :confirmed_at, type: DateTime

      before_create :generate_confirmation_token
      after_create :send_on_create_confirmation_instructions, if: :send_confirmation_instructions?
    end

    module ClassMethods
      def confirm_by_token(token)
        confirmable = self.find_by(:confirmation_token, token)
        confirmable.confirm!
        confirmable
      end

      def find_unconfirmed_confirmable(token)
        confirmable = self.find_by(confirmation_token: token)
        return false if confirmable.confirmed?
        confirmable
      rescue Mongoid::Errors::DocumentNotFound
        false
      end
    end

    def confirm!
      return false if confirmed?
      self.confirmation_token = nil
      self.confirmed_at = Time.now
      save
    end

    def confirmed?
      !!confirmed_at
    end

    def confirmation_required?
      !confirmed?
    end

    def skip_confirmation_instructions!
      @skip_confirmation_instructions = true
    end

    protected
    def generate_confirmation_token
      self.confirmation_token = Signap.generate_token
    end

    def generate_confirmation_token!
      self.generate_confirmation_token; save
    end

    def send_on_create_confirmation_instructions
      Signap::Mailer.confirmation_instructions(self).deliver
    end

    def send_confirmation_instructions?
      confirmation_required? && !@skip_confirmation_instructions
    end
  end
end
