class Api::V1::Merchants::FindController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.where(merchant_params).order(:id))
  end
private
  def merchant_params
    params.permit(:id, :name, :updated_at, :created_at)
  end
end
