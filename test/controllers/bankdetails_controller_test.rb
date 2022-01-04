require "test_helper"

class BankdetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bankdetail = bankdetails(:one)
  end

  test "should get index" do
    get bankdetails_url
    assert_response :success
  end

  test "should get new" do
    get new_bankdetail_url
    assert_response :success
  end

  test "should create bankdetail" do
    assert_difference('Bankdetail.count') do
      post bankdetails_url, params: { bankdetail: { account_name: @bankdetail.account_name, bic: @bankdetail.bic, country: @bankdetail.country, iban: @bankdetail.iban, user_id: @bankdetail.user_id } }
    end

    assert_redirected_to bankdetail_url(Bankdetail.last)
  end

  test "should show bankdetail" do
    get bankdetail_url(@bankdetail)
    assert_response :success
  end

  test "should get edit" do
    get edit_bankdetail_url(@bankdetail)
    assert_response :success
  end

  test "should update bankdetail" do
    patch bankdetail_url(@bankdetail), params: { bankdetail: { account_name: @bankdetail.account_name, bic: @bankdetail.bic, country: @bankdetail.country, iban: @bankdetail.iban, user_id: @bankdetail.user_id } }
    assert_redirected_to bankdetail_url(@bankdetail)
  end

  test "should destroy bankdetail" do
    assert_difference('Bankdetail.count', -1) do
      delete bankdetail_url(@bankdetail)
    end

    assert_redirected_to bankdetails_url
  end
end
