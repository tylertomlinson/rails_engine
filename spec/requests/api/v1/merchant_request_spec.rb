require 'rails_helper'

describe 'Merchants request API' do
  before :each do
    create_list(:merchant, 5)

    get '/api/v1/merchants'
    @merchants = JSON.parse(response.body)

    @merchant1 = @merchants['data'].first
    get "/api/v1/merchants/#{@merchant1['id']}"
    @merchant1_info = JSON.parse(response.body)
  end

  it 'can get a list of all merchants' do
    expect(response).to be_successful
    expect(@merchants['data'].count).to eq(5)
    expect(@merchants.class).to eq(Hash)
  end

  it 'can get data on one merchant' do
    merchant_attributes = @merchants['data'].first['attributes']

    expect(merchant_attributes['name']).to eq(@merchant1['attributes']['name'])
  end

  it 'data is ordered correctly' do
    first_merchant_data = @merchants['data'].first
    second_merchant_data = @merchants['data'].second
    third_merchant_data = @merchants['data'][2]
    a = 'attributes'
    merchant1 = @merchants['data'].first
    merchant2 = @merchants['data'].second
    merchant3 = @merchants['data'][2]

    expect(first_merchant_data['id']).to eq(merchant1['id'])
    expect(first_merchant_data[a]['name']).to eq(merchant1[a]['name'])
    expect(first_merchant_data['type']).to eq('merchant')
    expect(first_merchant_data[a]['name']).to_not eq(merchant2[a]['name'])

    expect(second_merchant_data['id']).to eq(merchant2['id'])
    expect(second_merchant_data[a]['name']).to eq(merchant2[a]['name'])
    expect(second_merchant_data['type']).to eq('merchant')
    expect(second_merchant_data[a]['name']).to_not eq(merchant1[a]['name'])

    expect(third_merchant_data['id']).to eq(merchant3['id'])
    expect(third_merchant_data[a]['name']).to eq(merchant3[a]['name'])
    expect(third_merchant_data['type']).to eq('merchant')
    expect(third_merchant_data[a]['name']).to_not eq(merchant2[a]['name'])
  end

  it 'data is shown correctly' do
    merchant_info = @merchant1_info['data']['attributes']
    expect(merchant_info['name']).to eq(@merchant1['attributes']['name'])
  end

  it 'can create merchant' do
    merchant_params = { name: 'test name' }

    post '/api/v1/merchants', params: { merchant: merchant_params }
    expect(response).to be_successful

    new_merchant = Merchant.last

    expect(new_merchant.name).to eq(merchant_params[:name])
  end

  it 'can update merchant' do
    merchant = create(:merchant, name: 'test name')

    merchant_params = { name: 'test name updated' }

    patch "/api/v1/merchants/#{merchant.id}", params: { merchant: merchant_params }

    expect(response).to be_successful
    updated_merchant = Merchant.find(merchant.id)
    expect(updated_merchant.name).to eq('test name updated')
  end

  it 'can delete merchant' do
    merchant_id = @merchant1['id']

    delete "/api/v1/merchants/#{merchant_id}"

    expect(response).to be_successful
    expect(Merchant.all.count).to eq(4)
    expect { Merchant.find(merchant_id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
