class BankAccountsController < ApplicationController
  before_action :set_bank_account, only: %i[ show update destroy add_money withdraw_money transfer_money ]

  # GET /bank_accounts
  # GET /bank_accounts.json
  def index
    @bank_accounts = BankAccount.all
  end

  # GET /bank_accounts/1
  # GET /bank_accounts/1.json
  def show
  end

  # POST /bank_accounts
  # POST /bank_accounts.json
  def create
    @bank_account = BankAccount.new(bank_account_params)

    if @bank_account.save
      render :show, status: :created, location: @bank_account
    else
      render json: @bank_account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bank_accounts/1
  # PATCH/PUT /bank_accounts/1.json
  def update
    if @bank_account.update(bank_account_params)
      render :show, status: :ok, location: @bank_account
    else
      render json: @bank_account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bank_accounts/1
  # DELETE /bank_accounts/1.json
  def destroy
    @bank_account.destroy
  end

  # POST /bank_accounts/1/add_money.json
  def add_money
    # @bank_account = BankAccount.find(params[:id])
    @bank_account_transaction = @bank_account.add_money(amount: bank_account_money_params[:amount],
                                                        execution_date: bank_account_money_params[:execution_date],
                                                        remarks: bank_account_money_params[:remarks])

    if @bank_account_transaction.errors.blank?
      render :bank_account_transaction, status: :created
    else
      render json: @bank_account_transaction.errors, status: :unprocessable_entity
    end
  end

  def withdraw_money
    # @bank_account = BankAccount.find(params[:id])
    @bank_account_transaction = @bank_account.withdraw_money(amount: bank_account_money_params[:amount],
                                                        execution_date: bank_account_money_params[:execution_date],
                                                        remarks: bank_account_money_params[:remarks])

    if @bank_account_transaction.errors.blank?
      render :bank_account_transaction, status: :created
    else
      render json: @bank_account_transaction.errors, status: :unprocessable_entity
    end
  end

  def transfer_money
    # @bank_account = BankAccount.find(params[:id])
    @bank_account_transaction = @bank_account.transfer_money(amount: bank_account_money_params[:amount],
                                                             execution_date: bank_account_money_params[:execution_date],
                                                             remarks: bank_account_money_params[:remarks],
                                                             recipient_bank_account_number: bank_account_money_params[:recipient_bank_account_number],
                                                             recipient_bank_account_type: bank_account_money_params[:recipient_bank_account_type],
                                                             recipient_bank_account_holders_name: bank_account_money_params[:recipient_bank_account_holders_name],
                                                             recipient_bank_account_ifsc_code: bank_account_money_params[:recipient_bank_account_ifsc_code],
                                                             recipient_bank_name: bank_account_money_params[:recipient_bank_name],
                                                             recipient_bank_branch: bank_account_money_params[:recipient_bank_branch]
                                                            )

    if @bank_account_transaction.errors.blank?
      render :bank_account_transaction, status: :created
    else
      render json: @bank_account_transaction.errors, status: :unprocessable_entity
    end
  end

  def statement
    @bank_account = BankAccount.find_by(account_number: bank_account_statement_params[:account_number],
                                        ifsc_code: bank_account_statement_params[:ifsc_code])
    
    if @bank_account
      @statement = @bank_account.fetch_statement(start_date: bank_account_statement_params[:start_date],
                                                end_date: bank_account_statement_params[:end_date])
      
      if @statement[:status]
        render :statement, status: :ok
      else
        render json: @statement[:errors], status: :unprocessable_entity
      end
    else
      render json: 'Valid bank account was not found!', status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank_account
      @bank_account = BankAccount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bank_account_params
      params.require(:bank_account).permit(:user_id, :account_number, :ifsc_code, :bank_name, :opening_balance)
    end

    def bank_account_money_params
      params.permit(:amount, :execution_date, :remarks, :recipient_bank_account_number, :recipient_bank_account_type, :recipient_bank_account_holders_name, :recipient_bank_account_ifsc_code, :recipient_bank_name, :recipient_bank_branch)
    end

    def bank_account_statement_params
      params.permit(:account_number, :ifsc_code, :start_date, :end_date)
    end
end
