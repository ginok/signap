module Signap
  module ApplicationHelper
    def user_class
      Signap.user_class
    end

    def singular_name
      ActiveModel::Naming.singular(user_class)
    end
  end
end
