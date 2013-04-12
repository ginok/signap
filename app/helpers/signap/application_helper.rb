module Signap
  module ApplicationHelper
    def user_class
      Signap.configuration.user_model
    end

    def singular_name
      ActiveModel::Naming.singular(user_class)
    end

    def additional_attributes
      Signap.configuration.additional_attributes
    end
  end
end
