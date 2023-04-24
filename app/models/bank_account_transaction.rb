class BankAccountTransaction < ApplicationRecord
  # Relationships
  belongs_to :bank_account

  # Validations
  validates :operation, :amount, presence: true
  validates :recipient_bank_account_number, :recipient_bank_account_type, :recipient_bank_account_holders_name, :recipient_bank_account_ifsc_code, :recipient_bank_name, :recipient_bank_branch, presence: true, if: :is_a_transfer_transaction?
  validates :operation, inclusion: { in: %w( credit debit transfer )}
  validates :amount, numericality: { greater_than: 0 }
  validate :sufficient_account_balance_for_debit_operation


  private
  def is_a_transfer_transaction?
    operation == 'transfer'
  end

  def sufficient_account_balance_for_debit_operation
    if operation == 'debit' || operation == 'transfer'
      if amount >= bank_account.balance
        errors.add(:amount, "is greater than balance to perform this transaction")
      end
    end
  end
end
