require "signap/engine"
require "signap/configuration"

module Signap

  def self.generate_token
    SecureRandom.urlsafe_base64(16)
  end
end
