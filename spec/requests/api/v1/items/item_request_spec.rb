require 'rails_helper'

RSpec.describe 'single merchant items page' do
  before(:each) do
    @merchant = create(:merchant)

    create_list(:item, 7)

    get '/api/v1/items'

    @items = JSON.parse(response.body)
  end

  it 'can get list of items' do
    expect(response).to be_successful
    expect(@items['data'].count).to eq(7)
    expect(@items.class).to eq(Hash)
  end
end

# expect(items['data'].first['attributes']['name']).to eq(item1.name)
# expect(items['data'].first['attributes']['merchant_id']).to eq(merchant.id)
