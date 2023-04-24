json.extract! bank_account_transaction, :id, :amount, :operation, :execution_date
json.bank_account_number bank_account.account_number
json.bank_name bank_account.bank_name
json.account_holders_name bank_account.user.name
json.extract! bank_account_transaction,  :remarks, :created_at, :updated_at

if bank_account_transaction.operation == 'transfer'
    json.extract! bank_account_transaction, :recipient_bank_account_number, :recipient_bank_account_type, :recipient_bank_account_holders_name, :recipient_bank_account_ifsc_code, :recipient_bank_name, :recipient_bank_branch
end
