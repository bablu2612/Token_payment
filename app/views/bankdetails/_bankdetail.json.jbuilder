json.extract! bankdetail, :id, :account_name, :country, :iban, :bic, :user_id, :created_at, :updated_at
json.url bankdetail_url(bankdetail, format: :json)
