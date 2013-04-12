module Signap
  class Configuration
    attr_accessor :user_model,
      :redirect_url_after_registeration,
      :redirect_url_after_login,
      :additional_attributes

    def initialize
      @redirect_url_after_registeration = '/'
      @redirect_url_after_login = '/'
      @additional_attributes = [:password]
    end
  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
  end
end
