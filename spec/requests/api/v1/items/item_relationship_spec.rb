require 'rails_helper'

describe 'Relationship merchant' do
  it 'can return a merchant for an item' do

    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful
    merchant_info = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_info[:data][:attributes][:name]).to eq(merchant.name)
  end
end
