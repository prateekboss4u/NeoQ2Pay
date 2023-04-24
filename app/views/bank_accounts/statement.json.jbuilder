json.account_number @bank_account.account_number
json.current_balance @bank_account.balance
json.statement do
  json.array! @statement[:transactions], partial: "bank_accounts/bank_account_transaction", as: :bank_account_transaction, bank_account: @bank_account
end

