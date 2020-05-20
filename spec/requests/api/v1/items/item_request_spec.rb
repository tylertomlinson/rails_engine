require 'rails_helper'

RSpec.describe 'single merchant items page' do
  it 'shows all items for a specific merchant' do
    merchant = create(:merchant)
    item1 = create(:item, merchant_id: merchant.id)
    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.class).to eq(Hash)
    expect(items['data'].length).to eq(3)
    expect(items['data'].first['attributes']['name']).to eq(item1.name)
    expect(items['data'].first['attributes']['merchant_id']).to eq(merchant.id)
  end
end
