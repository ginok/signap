module Signap
  module User
    extend ActiveSupport::Concern
    include Signap::SecurePassword

    included do
      has_secure_password
      field :email, type: String

      include Validations
    end

    module Validations
      extend ActiveSupport::Concern

      included do
        validates :email, presence: true, uniqueness: true
        validates_format_of :email, with: %r{\A[a-z0-9!#\$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\Z}i
      end
    end

    module ClassMethods
      def authenticate(email, password)
        user = self.find_by(email: email)
        user.authenticate(password) ? user : nil
      end
    end
  end
end
