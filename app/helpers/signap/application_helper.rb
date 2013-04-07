module Signap
  module ApplicationHelper
    def user_class
      Signap.configuration.user_model
    end

    def singular_name
      ActiveModel::Naming.singular(user_class)
    end
  end
end
