class BankAccount < ApplicationRecord
  # Relationships
  belongs_to :user
  has_many :bank_account_transactions

  #Validations
  validates :account_number, presence: true, uniqueness: { scope: :ifsc_code }
  validates :ifsc_code, presence: true
  validates :bank_name, presence: true
  validates :opening_balance, presence: true
  validates :opening_balance, numericality: { in: 0.01..99999999.99 }

  # Regular Methods
  def balance
    # credit : +
    # debit : -
    # transfer: -
    credited_amount = bank_account_transactions.where(operation: 'credit').sum(:amount)
    debited_amount = bank_account_transactions.where(operation: ['debit', 'transfer']).sum(:amount)

    opening_balance + credited_amount - debited_amount
  end

  def add_money(amount: 0, execution_date: Date.today, remarks: nil)
    perform_bank_account_transaction(
      operation: 'credit',
      amount: amount,
      execution_date: execution_date,
      remarks: remarks
    )
  end

  def withdraw_money(amount: 0, execution_date: Date.today, remarks: nil)
    perform_bank_account_transaction(
      operation: 'debit',
      amount: amount,
      execution_date: execution_date,
      remarks: remarks
    )
  end

  def transfer_money(recipient_bank_account_number: nil, recipient_bank_account_type: nil, recipient_bank_account_holders_name: nil, recipient_bank_account_ifsc_code: nil, recipient_bank_name: nil, recipient_bank_branch: nil, amount: nil, remarks: nil, execution_date: Date.today)
    perform_bank_account_transaction(
      operation: 'transfer',
      amount: amount,
      execution_date: execution_date,
      remarks: remarks,
      recipient_bank_account_number: recipient_bank_account_number,
      recipient_bank_account_type: recipient_bank_account_type,
      recipient_bank_account_holders_name: recipient_bank_account_holders_name,
      recipient_bank_account_ifsc_code: recipient_bank_account_ifsc_code,
      recipient_bank_name: recipient_bank_name, 
      recipient_bank_branch: recipient_bank_branch
    )
  end

  def fetch_statement(start_date: nil, end_date: nil)
    errors = []
    start_date ||= Date.today - 30.days
    end_date ||= Date.today

    start_date_timestamp = Date.parse(start_date.to_s).beginning_of_day
    end_date_timestamp = Date.parse(end_date.to_s).end_of_day

    errors << "Provided start date is later than end date" if start_date_timestamp > end_date_timestamp
    errors << "Start date cannot be older than 1 year" if start_date_timestamp < Date.today - 1.year
    errors << "End date cannot be in the future" if end_date_timestamp > Date.today.end_of_day

    return { status: false, transactions: nil, errors: errors } unless errors.blank?

    return { status: true, transactions: bank_account_transactions.where(created_at: start_date_timestamp..end_date_timestamp), errors: nil }
  end

  private

  def perform_bank_account_transaction(amount: 0, execution_date: Date.today, remarks: nil, operation: nil, recipient_bank_account_number: nil, recipient_bank_account_type: nil, recipient_bank_account_holders_name: nil, recipient_bank_account_ifsc_code: nil, recipient_bank_name: nil, recipient_bank_branch: nil)
    bank_account_transactions.create(
      bank_account_id: id,
      operation: operation,
      amount: amount,
      execution_date: execution_date,
      remarks: remarks,
      recipient_bank_account_number: recipient_bank_account_number,
      recipient_bank_account_type: recipient_bank_account_type,
      recipient_bank_account_holders_name: recipient_bank_account_holders_name,
      recipient_bank_account_ifsc_code: recipient_bank_account_ifsc_code,
      recipient_bank_name: recipient_bank_name, 
      recipient_bank_branch: recipient_bank_branch
    )
  end
end
