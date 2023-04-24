class ChangeBalanceFieldInBankAccount < ActiveRecord::Migration[7.0]
  def change
    rename_column :bank_accounts, :balance, :opening_balance#, :decimal, precision: 10, scale: 2, null: false, default: 0.0
  end
end
