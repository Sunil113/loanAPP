class Admin < ApplicationRecord
  has_secure_password
  has_many :loans

end
