class BankAccountTransactionsController < ApplicationController

  # POST /bank_account_transactions
  # POST /bank_account_transactions.json
  def create
    @bank_account_transaction = BankAccountTransaction.new(bank_account_transaction_params)

    if @bank_account_transaction.save
      render :show, status: :created, location: @bank_account_transaction
    else
      render json: @bank_account_transaction.errors, status: :unprocessable_entity
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def bank_account_transaction_params
      params.require(:bank_account_transaction).permit(:bank_account_id, :operation, :amount, :execution_date, :remarks)
    end
end
