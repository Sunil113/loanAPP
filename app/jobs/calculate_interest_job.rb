class CalculateInterestJob < ApplicationJob
  queue_as :loans

  def perform
    Loan.where(status: :open).each do |loan|
      interest = loan.amount * (loan.interest_rate / 100) * (5.0 / (24 * 60))
      loan.update(amount: loan.amount + interest)
    end
  end
end
