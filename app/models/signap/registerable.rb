module Signap
  module Registerable
    extend ActiveSupport::Concern
    include ActiveModel::SecurePassword

    included do
      has_secure_password
      field :email, type: String
      field :password_digest, type: String
    end
  end
end
