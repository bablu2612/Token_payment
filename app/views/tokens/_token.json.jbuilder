json.extract! token, :id, :status, :amount, :response, :created_at, :updated_at
json.url token_url(token, format: :json)
