class BankdetailsController < ApplicationController
  before_action :set_bankdetail, only: %i[ show edit update destroy ]

  # GET /bankdetails or /bankdetails.json
  def index
    @bankdetails = Bankdetail.all
  end

  # GET /bankdetails/1 or /bankdetails/1.json
  def show
  end

  # GET /bankdetails/new
  def new
    @bankdetail = Bankdetail.new
  end

  # GET /bankdetails/1/edit
  def edit
  end

  # POST /bankdetails or /bankdetails.json
  def create
    @bankdetail = Bankdetail.new(bankdetail_params)

    respond_to do |format|
      if @bankdetail.save
        format.html { redirect_to tokens_path, notice: "Bankdetail was successfully created." }
        format.json { render :show, status: :created, location: @bankdetail }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bankdetail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bankdetails/1 or /bankdetails/1.json
  def update
    respond_to do |format|
      if @bankdetail.update(bankdetail_params)
        format.html { redirect_to tokens_path, notice: "Bankdetail was successfully updated." }
        format.json { render :show, status: :ok, location: @bankdetail }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bankdetail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bankdetails/1 or /bankdetails/1.json
  def destroy
    @bankdetail.destroy
    respond_to do |format|
      format.html { redirect_to bankdetails_url, notice: "Bankdetail was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bankdetail
      @bankdetail = Bankdetail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bankdetail_params
      params.require(:bankdetail).permit(:account_name, :country, :iban, :bic, :user_id)
    end
end
