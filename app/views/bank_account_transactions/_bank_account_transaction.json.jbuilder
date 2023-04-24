json.extract! bank_account_transaction, :id, :amount, :operation, :execution_date
json.bank_account_number bank_account_transaction.bank_account.account_number
json.bank_name bank_account_transaction.bank_account.bank_name
json.account_holders_name bank_account_transaction.bank_account.user.name
json.extract! bank_account_transaction,  :created_at, :updated_at
json.url bank_account_transaction_url(bank_account_transaction, format: :json)
