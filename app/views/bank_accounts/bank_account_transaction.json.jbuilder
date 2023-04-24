json.partial! "bank_accounts/bank_account_transaction", bank_account: @bank_account, bank_account_transaction: @bank_account_transaction
json.current_balance @bank_account.balance