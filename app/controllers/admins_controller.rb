class AdminsController < ApplicationController
  before_action :require_admin
  before_action :set_admin, only: [:show]

  def show
    @loan_requests = Loan.where(status: :requested)
    @active_loans = Loan.where(status: :open)
    @repaid_loans = Loan.where(status: :closed)
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end
end
