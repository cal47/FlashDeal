class DealsController < ApplicationController
  before_action :set_deal, only: [:show, :edit, :update, :destroy]
  before_action :check_is_vendor, only: [:create]

  def check_is_vendor
    if current_user.has_role?(:vendor)
      return true
    else
      redirect_to :root, error: "You can't create deals"
    end
  end

  # GET /deals
  # GET /deals.json
  def index
    @deals = Deal.includes(:user).find(:all, :order => "id desc", :limit => 3)
    @ret_arr = []
    @deals.each do |deal|
      if deal.user
        @ret_arr << deal.attributes.merge(deal.user.attributes.slice("latitude","longitude"))
      else
        @ret_arr << deal.attributes
      end
    end
    @some_deals = @ret_arr.to_json.html_safe
    # @deals = Deal.all
  end

  # GET /deals/1
  # GET /deals/1.json
  def show
  end

  # GET /deals/new
  def new
    @deal = Deal.new
    
  end

  # GET /deals/1/edit
  def edit
  end

  # POST /deals
  # POST /deals.json
  def create
    @deal = Deal.new(deal_params)
    @deal.user_id = current_user.id

    respond_to do |format|
      if @deal.save
        format.html { redirect_to @deal, notice: 'Deal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @deal }
      else
        format.html { render action: 'new' }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deals/1
  # PATCH/PUT /deals/1.json
  def update
    respond_to do |format|
      if @deal.update(deal_params)
        format.html { redirect_to @deal, notice: 'Deal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deals/1
  # DELETE /deals/1.json
  def destroy
    @deal.destroy
    respond_to do |format|
      format.html { redirect_to deals_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deal
      @deal = Deal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deal_params
      params.require(:deal).permit(:deal, :description, :start_time, :end_time, :user_id)
    end
end
