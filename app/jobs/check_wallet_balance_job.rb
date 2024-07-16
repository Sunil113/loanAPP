class CheckWalletBalanceJob < ApplicationJob
  queue_as :loans

  def perform
    Loan.where(status: :open).each do |loan|
      user = loan.user
      if loan.amount > user.wallet_balance
        amount_to_debit = user.wallet_balance
        user.update(wallet_balance: 0)
        loan.admin.update(wallet_balance: loan.admin.wallet_balance + amount_to_debit)
        loan.update(amount: loan.amount - amount_to_debit, status: :closed)
      end
    end
  end
end
