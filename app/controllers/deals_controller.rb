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

  # def initialize(attributes = nil)
  #   attr_with_defaults  
  # end

  def current_deals
    if params[:start_time] && params[:end_time]
     @deals = Deals.find(:all, :conditions => {:dateTime.now => start_date..end_date})
    end
  end

  # GET /deals
  # GET /deals.json
  def index
    @deals = Deal.all
    # OLD CODE--- this will give me the first 3 deals in the db
    # @limit_deals = Deal.find(:all, :order => "id desc", :limit =>3)
    # @ret_array = []
    # @deals.each do |deal|
    #   @ret_array << deal.attributes
    # end
    # @some_deals = @ret_array.to_json.html_safe

    # THE CODE BELOW IS FROM BEFORE THE ADDRESS WAS REMOVED FROM THE USER AND PLACED ON THE DEAL
    # @deals = Deal.includes(:user).find(:all, :order => "id desc", :limit => 3)
    # @ret_arr = []
    # @deals.each do |deal|
    #   if deal.user
    #     @ret_arr << deal.attributes.merge(deal.user.attributes.slice("latitude","longitude"))
    #   else
    #     @ret_arr << deal.attributes
    #   end
    # end
    # @some_deals = @ret_arr.to_json.html_safe
    # # @deals = Deal.all
  end

  # GET /deals/1
  # GET /deals/1.json
  def show
  end

  # GET /deals/new
  def new
    @deal = Deal.new
    @deal.street1 = current_user.street1
    @deal.city = current_user.city
    @deal.state = current_user.state
    @deal.zip = current_user.zip
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

  def nearby
    latitude = params[:latitude]
    longitude = params[:longitude]
    d = Deal.where("start_time <= :now AND end_time >= :now", {now: DateTime.now}, :order => "id desc", :limit =>3)
    deals_nearby = d.near([latitude, longitude], 3)
    render json: deals_nearby
    # render json: {:latitude => latitude}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deal
      @deal = Deal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deal_params
      params.require(:deal).permit(:deal, :description, :start_time, :end_time, :user_id, :street1, :city, :state, :zip, :address)
    end
end
