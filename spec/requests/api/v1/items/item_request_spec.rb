require 'rails_helper'

RSpec.describe 'single merchant items page' do
  before(:each) do
    @merchant = create(:merchant)
    create_list(:item, 7)

    get '/api/v1/items'
    @items = JSON.parse(response.body)

    @item1 = @items['data'].first
    get "/api/v1/items/#{@item1['id']}"
    @item1_info = JSON.parse(response.body)
  end

  it 'can get list of items' do
    expect(response).to be_successful
    expect(@items['data'].count).to eq(7)
    expect(@items.class).to eq(Hash)
  end

  it 'can get data on one item' do
    expect(@items['data'].first['attributes']['name']).to eq(@item1['attributes']['name'])
    expect(@items['data'].first['attributes']['desciption']).to eq(@item1['description'])
    expect(@items['data'].first['attributes']['unit_price']).to eq(@item1['attributes']['unit_price'])
    expect(@items['data'].first['attributes']['merchant_id']).to eq(@item1['attributes']['merchant_id'])
  end

  it 'data is ordered correctly' do
    item1 = @items['data'].first
    item2 = @items['data'].second
    item3 = @items['data'][2]

    expect(@items['data'].first['id']).to eq(item1['id'])
    expect(@items['data'].first['name']).to eq(item1['name'])
    expect(@items['data'].first['type']).to eq('item')

    expect(@items['data'].second['id']).to eq(item2['id'])
    expect(@items['data'].second['name']).to eq(item2['name'])
    expect(@items['data'].second['type']).to eq('item')

    expect(@items['data'][2]['id']).to eq(item3['id'])
    expect(@items['data'][2]['name']).to eq(item3['name'])
    expect(@items['data'][2]['type']).to eq('item')
  end

  it 'data is shown correctly' do
    expect(@item1_info['data']['name']).to eq(@item1['name'])
    expect(@item1_info['data']['desciption']).to eq(@item1['description'])
    expect(@item1_info['data']['unit_price']).to eq(@item1['unit_price'])
    expect(@item1_info['data']['merchant_id']).to eq(@item1['merchant_id'])
  end

  



end
