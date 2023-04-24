require "test_helper"

class BankAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bank_account = bank_accounts(:one)
  end

  test "should get index" do
    get bank_accounts_url, as: :json
    assert_response :success
  end

  test "should create bank_account" do
    assert_difference("BankAccount.count") do
      post bank_accounts_url, params: { bank_account: { account_number: @bank_account.account_number, opening_balance: @bank_account.opening_balance, bank_name: @bank_account.bank_name, ifsc_code: @bank_account.ifsc_code, user_id: @bank_account.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show bank_account" do
    get bank_account_url(@bank_account), as: :json
    assert_response :success
  end

  test "should update bank_account" do
    patch bank_account_url(@bank_account), params: { bank_account: { account_number: @bank_account.account_number, opening_balance: @bank_account.opening_balance, bank_name: @bank_account.bank_name, ifsc_code: @bank_account.ifsc_code, user_id: @bank_account.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy bank_account" do
    assert_difference("BankAccount.count", -1) do
      delete bank_account_url(@bank_account), as: :json
    end

    assert_response :no_content
  end
end
