json.extract! bank_account, :id, :account_number, :ifsc_code, :bank_name
json.account_holder_name bank_account.user.name
json.extract! bank_account, :opening_balance, :created_at, :updated_at
json.url bank_account_url(bank_account, format: :json)
