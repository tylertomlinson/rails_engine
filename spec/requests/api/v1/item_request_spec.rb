require 'rails_helper'

RSpec.describe 'Items request API' do
  before(:each) do
    @merchant = create(:merchant)
    create_list(:item, 7)

    get '/api/v1/items'
    @items = JSON.parse(response.body)

    @item1 = @items['data'].first
    get "/api/v1/items/#{@item1['id']}"
    @item1_info = JSON.parse(response.body)
  end

  it 'can get list of all items' do
    expect(response).to be_successful
    expect(@items['data'].count).to eq(7)
    expect(@items.class).to eq(Hash)
  end

  it 'can get data on one item' do
    item_attributes = @items['data'].first['attributes']

    expect(item_attributes['name']).to eq(@item1['attributes']['name'])
    expect(item_attributes['description']).to eq(@item1['attributes']['description'])
    expect(item_attributes['unit_price']).to eq(@item1['attributes']['unit_price'])
    expect(item_attributes['merchant_id']).to eq(@item1['attributes']['merchant_id'])
  end

  it 'data is ordered correctly' do
    first_item_data = @items['data'].first['attributes']
    second_item_data = @items['data'].second['attributes']
    third_item_data = @items['data'][2]['attributes']
    a = 'attributes'
    item1 = @items['data'].first
    item2 = @items['data'].second
    item3 = @items['data'][2]

    expect(first_item_data['id']).to eq(item1[a]['id'])
    expect(first_item_data['name']).to eq(item1[a]['name'])
    expect(first_item_data['type']).to eq(item1['item'])
    expect(first_item_data['id']).to_not eq(item2[a]['id'])
    expect(first_item_data['name']).to_not eq(item2[a]['name'])

    expect(second_item_data['id']).to eq(item2[a]['id'])
    expect(second_item_data['name']).to eq(item2[a]['name'])
    expect(second_item_data['type']).to eq(item2['item'])
    expect(second_item_data['id']).to_not eq(item1[a]['id'])
    expect(second_item_data['name']).to_not eq(item1[a]['name'])

    expect(third_item_data['id']).to eq(item3[a]['id'])
    expect(third_item_data['name']).to eq(item3[a]['name'])
    expect(third_item_data['type']).to eq(item3['item'])
    expect(third_item_data['id']).to_not eq(item2[a]['id'])
    expect(third_item_data['name']).to_not eq(item2[a]['name'])
  end

  it 'data is shown correctly' do
    item_data = @item1_info['data']
    expect(item_data['name']).to eq(@item1['name'])
    expect(item_data['description']).to eq(@item1['description'])
    expect(item_data['unit_price']).to eq(@item1['unit_price'])
    expect(item_data['merchant_id']).to eq(@item1['merchant_id'])
  end

  it 'can create new item' do
    item_params = { name: 'test name', description: 'test description', unit_price: '200', merchant_id: @merchant.id }

    post '/api/v1/items', params: { item: item_params }
    expect(response).to be_successful

    new_item = Item.last

    expect(new_item.name).to eq(item_params[:name])
  end

  it 'can update item' do
    item_id = @item1['id']

    item_params = { name: 'test name updated', description: 'test description', unit_price: 200, merchant_id: @merchant.id }

    patch "/api/v1/items/#{item_id}", params: { item: item_params }

    expect(response).to be_successful
    updated_item = Item.find(item_id)
    expect(updated_item.name).to eq('test name updated')
  end

  it 'can delete item' do
    item_id = @item1['id']

    delete "/api/v1/items/#{item_id}"

    expect(response).to be_successful
    expect(Item.all.count).to eq(6)
    expect { Item.find(item_id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
