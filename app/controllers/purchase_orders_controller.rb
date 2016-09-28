class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: [:show, :update, :destroy]

  # GET /purchase_orders
  # GET /purchase_orders.json
  def index
    render :json => {:purchase_orders => Listings.get_po_details_with_store_name}
  end

  # GET /purchase_orders/1
  # GET /purchase_orders/1.json
  def show
    if @purchase_order
      render :json => TransformOutput.transform_po(@purchase_order)
    else
      # To return a 404 the commented part below can be uncommented. However, this API returns 200 for all
      # scenarios and communicates via error messages. Converting to the other format will not be a problem though.
      render :json => {:error => "Unable to find purchase order"}#, :status => :not_found
    end
  end

  # POST /purchase_orders
  # POST /purchase_orders.json
  def create
    @purchase_order = PurchaseOrder.new(purchase_order_create_params)
    
    if @purchase_order.save
      render :json => {:message => "Successully created purchase order"}
    else
      render :json => {:error => @purchase_order.errors}
    end
  end

  # PATCH/PUT /purchase_orders/1
  # PATCH/PUT /purchase_orders/1.json
  def update
    if @purchase_order.update(purchase_order_update_params)
        render :json => {:message => "Successully updated purchase order"}, status: :ok
    else
        render :json => {:error => @purchase_order.errors}
    end
    
  end

  # DELETE /purchase_orders/1
  # DELETE /purchase_orders/1.json
  def destroy
    @purchase_order.destroy
    
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_order
      @purchase_order = PurchaseOrder.where(:id => params[:id].to_i).includes(:store).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_order_create_params
      params.require(:purchase_order).permit(:store_id, :name)
    end

    # Store association can't be updated
    def purchase_order_update_params
      params.require(:purchase_order).permit(:name)
    end
end
