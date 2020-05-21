class Api::V1::Merchants::FindController < ApplicationController
  def index
    merchants = if merchant_params[:name]
      merchants = Merchant.search_all_by_name(merchant_params[:name])
    else
      merchants = Merchant.where(merchant_params)
    end
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = if merchant_params[:name]
      Merchant.search_by_name(merchant_params[:name])
    else
      Merchant.find_by(merchant_params)
    end
    render json: MerchantSerializer.new(merchant)
  end
  
  private

  def merchant_params
    params.permit(:id, :name, :updated_at, :created_at)
  end
end
