module Signap
  module Omniauthable
    extend ActiveSupport::Concern

    included do
      field :signap_omni_id_facebook, type: String
    end

    module ClassMethods
      def find_or_create_omniauthable(provider, auth_hash)
        params = parse(auth_hash)
        omniauthable = self.find_or_initialize_by(signap_omni_id_facebook: params.delete(:id))
        if omniauthable.new_record?
          omniauthable.assign_attributes(params)
          omniauthable.save!
        end
        omniauthable
      end

      protected
      def parse(auth_hash)
        {
          id: auth_hash[:uid],
          email: auth_hash[:info][:email],
          nickname: auth_hash[:info][:name]
        }
      end
    end
  end
end
