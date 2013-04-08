module Signap
  module Confirmable
    extend ActiveSupport::Concern

    included do
      field :confirmation_token, type: String
      field :confirmed_at, type: DateTime

      before_create :generate_confirmation_token, if: :confirmation_required?
    end

    def confirm!
      self.confirmation_token = nil
      self.confirmed_at = Time.now
      save
    end

    def confirmed?
      !!confirmed_at
    end

    def generate_confirmation_token
      self.confirmation_token = Signap.generate_token
    end

    def generate_confirmation_token!
      self.generate_confirmation_token; save
    end

    protected
    def confirmation_required?
      !confirmed?
    end
  end
end
