require 'rails_helper'

RSpec.describe 'Merchants find controller' do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
  end

  it 'can find merchant by id' do
    get "/api/v1/merchants/find?id=#{@merchant1.id}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)['data']

    expect(merchant_info['attributes']['id']).to eq(@merchant1.id)
    expect(merchant_info['attributes']['name']).to_not eq(@merchant2.name)
  end

  it 'can find merchant by name' do
    get "/api/v1/merchants/find?name=#{@merchant1.name}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)['data']

    expect(merchant_info['attributes']['id']).to eq(@merchant1.id)
    expect(merchant_info['attributes']['name']).to_not eq(@merchant2.name)
  end

  it 'can find merchant based on created date' do
    get "/api/v1/merchants/find?created_at=#{@merchant1.created_at}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)['data']

    expect(merchant_info['attributes']['name']).to eq(@merchant1.name)
    expect(merchant_info['attributes']['id']).to_not eq(@merchant2.id)
  end

  it 'can find merchant based on updated date' do
    get "/api/v1/merchants/find?updated_at=#{@merchant1.updated_at}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)['data']

    expect(merchant_info['attributes']['name']).to eq(@merchant1.name)
    expect(merchant_info['attributes']['id']).to_not eq(@merchant2.id)
  end

  it 'can find merchant with multiple attributes' do
    get "/api/v1/merchants/find?name#{@merchant1.name}=&id=#{@merchant1.id}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)['data']

    expect(merchant_info['attributes']['name']).to eq(@merchant1.name)
    expect(merchant_info['attributes']['id']).to_not eq(@merchant2.id)
  end

  it 'can find merchant with case insensitive for name' do
    upcase_name = @merchant1.name.upcase
    downcase_name = @merchant1.name.downcase

    get "/api/v1/merchants/find?name=#{upcase_name}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)['data']

    expect(merchant_info['attributes']['name']).to eq(@merchant1.name)
    expect(merchant_info['attributes']['id']).to_not eq(@merchant2.id)

    get "/api/v1/merchants/find?name=#{downcase_name}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)['data']

    expect(merchant_info['attributes']['name']).to eq(@merchant1.name)
    expect(merchant_info['attributes']['id']).to_not eq(@merchant2.id)
  end

  it 'can find all merchants info by name' do
    merchant1 = create(:merchant, name: 'tyler')
    merchant2 = create(:merchant, name: 'tyler')
    merchant3 = create(:merchant, name: 'tyler')
    merchant4 = create(:merchant, name: 'tyler tomlinson')
    merchant5 = create(:merchant, name: 'test')

    get '/api/v1/merchants/find_all?name=tyler'

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body)['data']
    expect(merchant_info.count).to eq(4)
    expect(merchant_info.first['attributes']['name']).to eq(merchant1.name)
    expect(merchant_info.second['attributes']['name']).to eq(merchant2.name)
    expect(merchant_info[2]['attributes']['name']).to eq(merchant3.name)
    expect(merchant_info[3]['attributes']['name']).to eq(merchant4.name)
    expect(merchant_info.last['attributes']['name']).to_not eq(merchant5.name)
  end
end
