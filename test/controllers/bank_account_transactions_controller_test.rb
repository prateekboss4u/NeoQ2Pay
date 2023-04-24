require "test_helper"

class BankAccountTransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bank_account_transaction = bank_account_transactions(:one)
  end

  test "should get index" do
    get bank_account_transactions_url, as: :json
    assert_response :success
  end

  test "should create bank_account_transaction" do
    assert_difference("BankAccountTransaction.count") do
      post bank_account_transactions_url, params: { bank_account_transaction: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show bank_account_transaction" do
    get bank_account_transaction_url(@bank_account_transaction), as: :json
    assert_response :success
  end

  test "should update bank_account_transaction" do
    patch bank_account_transaction_url(@bank_account_transaction), params: { bank_account_transaction: {  } }, as: :json
    assert_response :success
  end

  test "should destroy bank_account_transaction" do
    assert_difference("BankAccountTransaction.count", -1) do
      delete bank_account_transaction_url(@bank_account_transaction), as: :json
    end

    assert_response :no_content
  end
end
