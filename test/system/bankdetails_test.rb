require "application_system_test_case"

class BankdetailsTest < ApplicationSystemTestCase
  setup do
    @bankdetail = bankdetails(:one)
  end

  test "visiting the index" do
    visit bankdetails_url
    assert_selector "h1", text: "Bankdetails"
  end

  test "creating a Bankdetail" do
    visit bankdetails_url
    click_on "New Bankdetail"

    fill_in "Account name", with: @bankdetail.account_name
    fill_in "Bic", with: @bankdetail.bic
    fill_in "Country", with: @bankdetail.country
    fill_in "Iban", with: @bankdetail.iban
    fill_in "User", with: @bankdetail.user_id
    click_on "Create Bankdetail"

    assert_text "Bankdetail was successfully created"
    click_on "Back"
  end

  test "updating a Bankdetail" do
    visit bankdetails_url
    click_on "Edit", match: :first

    fill_in "Account name", with: @bankdetail.account_name
    fill_in "Bic", with: @bankdetail.bic
    fill_in "Country", with: @bankdetail.country
    fill_in "Iban", with: @bankdetail.iban
    fill_in "User", with: @bankdetail.user_id
    click_on "Update Bankdetail"

    assert_text "Bankdetail was successfully updated"
    click_on "Back"
  end

  test "destroying a Bankdetail" do
    visit bankdetails_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bankdetail was successfully destroyed"
  end
end
