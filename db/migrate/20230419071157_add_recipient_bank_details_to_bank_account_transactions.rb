class AddRecipientBankDetailsToBankAccountTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :bank_account_transactions, :recipient_bank_account_number, :string
    add_column :bank_account_transactions, :recipient_bank_account_type, :string
    add_column :bank_account_transactions, :recipient_bank_account_holders_name, :string
    add_column :bank_account_transactions, :recipient_bank_account_ifsc_code, :string
    add_column :bank_account_transactions, :recipient_bank_name, :string
    add_column :bank_account_transactions, :recipient_bank_branch, :string
  end
end
