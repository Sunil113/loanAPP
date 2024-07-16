class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :admin


  enum status: { requested: 0, approved: 1, open: 2, closed: 3, rejected: 4 }
end
