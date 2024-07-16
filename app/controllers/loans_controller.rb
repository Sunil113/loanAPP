class LoansController < ApplicationController
  before_action :require_login
  before_action :set_loan, only: [:show, :update]
  def new
    @user = User.find(params[:user_id])
    @loan = @user.loans.build
  end
  def create
    @user = User.find(params[:user_id])
    @loan = @user.loans.build(loan_params)
    @loan.admin = Admin.first # Assuming there's only one admin
    if @loan.save
      redirect_to @user, notice: 'Loan request submitted successfully.'
    else
      render :new
    end
  end


  def update
    if @loan.update(loan_params)
      if @loan.status == 'approved' && loan_params[:status] == 'open'
        transfer_funds
      elsif @loan.status == 'open' && loan_params[:status] == 'closed'
        repay_loan
      end
      redirect_to current_user, notice: 'Loan updated successfully.'
    else
      render :edit
    end
  end

  private

  def set_loan
    @loan = Loan.find(params[:id])
  end

  def loan_params
    params.require(:loan).permit(:amount, :interest_rate, :status)
  end

  def transfer_funds
    @loan.admin.update(wallet_balance: @loan.admin.wallet_balance - @loan.amount)
    @loan.user.update(wallet_balance: @loan.user.wallet_balance + @loan.amount)
  end

  def repay_loan
    amount_to_repay = [@loan.amount, @loan.user.wallet_balance].min
    @loan.user.update(wallet_balance: @loan.user.wallet_balance - amount_to_repay)
    @loan.admin.update(wallet_balance: @loan.admin.wallet_balance + amount_to_repay)
    @loan.update(amount: @loan.amount - amount_to_repay)
    @loan.update(status: :closed) if @loan.amount.zero?
  end

  def loan_params
    params.require(:loan).permit(:amount, :interest_rate, :status)
  end
end
