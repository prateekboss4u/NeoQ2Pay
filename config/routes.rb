Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users

  post 'bank_accounts/:id/add_money', to: 'bank_accounts#add_money', as: 'bank_account_add_money'
  post 'bank_accounts/:id/withdraw_money', to: 'bank_accounts#withdraw_money', as: 'bank_account_withdraw_money'
  post 'bank_accounts/:id/transfer_money', to: 'bank_accounts#transfer_money', as: 'bank_account_transfer_money'
  get 'bank_accounts/statement', to: 'bank_accounts#statement', as: 'bank_account_statement'
  resources :bank_accounts
end
