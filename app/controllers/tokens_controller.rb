class TokensController < ApplicationController
  before_action :set_token, only: %i[ show edit update destroy ]
  before_action :set_config_data, only: %i[ payment paid get_transfer_details ]
  skip_before_action :verify_authenticity_token, :only => [:payment,:paid]
  before_action :require_login

  require "uri"
  require "json"
  require "net/http"
  # GET /tokens or /tokens.json
  def index
    @tokens = Token.all
    render layout: "application"
  end

  #send request and genrate token using token_payment api.
  def payment
    redirect_url="#{request.protocol + request.host}/paid"
    url = URI("#{@baseurl}/token-requests")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["Authorization"] = @authorization_code
    request["Content-Type"] = "application/json"
    request.body = JSON.dump({
      "requestPayload": {
        "refId": "#{(0...16).map { ('a'..'z').to_a[rand(26)] }.join}",
        "to": {
          "alias": {
            "type": "DOMAIN",
            "value": "sysadmin@zero2one.ee",
            "realm": "",
            "realmId": ""
          },
          "id": @member_id
        },
        "transferBody": {
          "currency": "EUR",
          "lifetimeAmount": params[:amount],
          "instructions": {
            "transferDestinations": [
              {
                "sepa": {
                  "iban": params[:iban],
                  "bic": ""
                }
              }
            ]
          }
        },
        "description": params[:descriptions],
        "redirectUrl": "#{@redirect_app_url}/paid?amount=#{params[:amount]}",
        "customizationId": @customizationId
      }
    })
    response = https.request(request)
    data = eval(response.body)
    redirect_to "#{@web_app_url_redirection}/request-token/#{data[:tokenRequest][:id]}/?dk=global-test"
  end


  #pay amount using token payment gateway.
  def paid
    url = URI("#{@baseurl}/transfers")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["Authorization"] = @authorization_code
    request["Content-Type"] = "application/json"
    request.body = JSON.dump({
      "payload": {
        "refId": "#{(0...16).map { ('a'..'z').to_a[rand(26)] }.join}",
        "tokenId": params[:tokenId],
        "amount": {
          "value": params[:amount],
          "currency": "EUR"
        }
      }
    })

    response = https.request(request)
    data = eval(response.read_body)
    Token.create amount: data[:transfer][:payload][:amount][:value],transfer_id: data[:transfer][:id] , status: data[:transfer][:status]
    respond_to do |format|
        format.html { redirect_to tokens_path, notice: data[:transfer][:status]=='SUCCESS'? 'Payment was successfully paidr' : response.read_body }
    end

  end

  def get_transfer_details
    transfer_id_token="t:6dDXcRUYZiN5uPuJAXFm1rFU7Q8RL8RmfrLYa25Bc2ko:5zKcENpV"
    url = URI("https://api.sandbox.token.io/transfers/#{transfer_id_token}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["Authorization"] = @authorization_code
    response = https.request(request)
  end

  # GET /tokens/1 or /tokens/1.json
  def show
  end

  # GET /tokens/new
  def new
    @token = Token.new
  end

  # GET /tokens/1/edit
  def edit
  end

  # POST /tokens or /tokens.json
  def create
    @token = Token.new(token_params)
    respond_to do |format|
      if @token.save
        format.html { redirect_to @token, notice: "Token was successfully created." }
        format.json { render :show, status: :created, location: @token }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @token.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tokens/1 or /tokens/1.json
  def update
    respond_to do |format|
      if @token.update(token_params)
        format.html { redirect_to @token, notice: "Token was successfully updated." }
        format.json { render :show, status: :ok, location: @token }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @token.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tokens/1 or /tokens/1.json
  def destroy
    @token.destroy
    respond_to do |format|
      format.html { redirect_to tokens_url, notice: "Token was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_token
      @token = Token.find(params[:id])
    end

    #set configuration for token payment gateway.
    def set_config_data
      @baseurl="https://api.sandbox.token.io"
      @authorization_code="Basic bS1MU3paRGt2SGgyQzFIN1pCSHJycG93TXk2UEotNXpLdFhFQXE6NzM4N2QyYmMtODZiYy00MTU4LTk1ZmYtYTI2Njg4NjZkOWVl"
      @member_id="m:LSzZDkvHh2C1H7ZBHrrpowMy6PJ:5zKtXEAq"
      @customizationId="cm:AWH68KSTwnzRfo9fS7w2FTTxcXeeBhLqvA5QiihS6xGj:5zKtXEAq"
      @web_app_url_redirection="https://web-app.sandbox.token.io"
      @redirect_app_url="http://localhost:3001"
      # @redirect_app_url=request.protocol + request.host
      # @iban_nummber="EE497700771004652178"
    end 
    # Only allow a list of trusted parameters through.
    def token_params
      params.require(:token).permit(:status, :amount, :response)
    end
end
