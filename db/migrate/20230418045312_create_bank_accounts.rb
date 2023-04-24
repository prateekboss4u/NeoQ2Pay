class CreateBankAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :bank_accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :account_number, null: false
      t.string :ifsc_code, null: false
      t.string :bank_name, null: false
      t.decimal :balance, null: false, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
