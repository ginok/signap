module Signap
  class Configuration
    attr_accessor :user_model, :redirect_url
  end

  def initialize
    @redirect_url = '/'
  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
  end
end
