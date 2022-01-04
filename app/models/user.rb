class User < ApplicationRecord
  has_one :bankdetail

  include Clearance::User
end
