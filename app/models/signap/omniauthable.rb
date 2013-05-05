module Signap
  module Omniauthable
    extend ActiveSupport::Concern

    included do
      field :signap_omni_id_facebook, type: String
    end

    module ClassMethods
      def find_or_create_omniauthable(provider, auth_hash)
        params = parse(provider, auth_hash)
        omniauthable = self.find_or_initialize_by(signap_omni_id_facebook: params.delete(:id))
        if omniauthable.new_record?
          omniauthable.assign_attributes(params)
          omniauthable.skip_confirmation_instructions!
          omniauthable.save!
        end
        omniauthable
      end

      protected
      def parse(provider, auth_hash)
        {
          id: auth_hash[:uid],
          email: auth_hash[:info][:email],
        }
      end
    end
  end
end
