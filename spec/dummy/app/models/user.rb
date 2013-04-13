class User
  include Mongoid::Document
  include Signap::User
  include Signap::Confirmable
  include Signap::Omniauthable
end
