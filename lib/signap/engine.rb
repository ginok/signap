module Signap
  class Engine < ::Rails::Engine
    isolate_namespace Signap

    require 'omniauth-facebook'
    middleware.use ::OmniAuth::Builder do
    end
  end
end
