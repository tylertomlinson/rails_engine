require 'rails_helper'

describe 'Merchants with most revenue' do
  it 'can get given number of merchants with most revenue' do
    customer = create(:customer)
    merchant1 = create(:merchant, name: 'test merchant 1')
    merchant2 = create(:merchant, name: 'test merchant 2')
    merchant3 = create(:merchant, name: 'test merchant 3')

    item1 = merchant1.items.create(name: 'test item 1', description: 'test', unit_price: 100)
    item2 = merchant2.items.create(name: 'test item 2', description: 'test', unit_price: 100)
    item3 = merchant3.items.create(name: 'test item 3', description: 'test', unit_price: 100)

    invoice1 = Invoice.create(status: 'shipped', merchant_id: merchant1.id, customer_id: customer.id)
    invoice1.invoice_items.create(item_id: item1.id, quantity: 100, unit_price: 100)
    invoice1.transactions.create(credit_card_number: '1234567812345678', result: 'success')

    invoice2 = Invoice.create(status: 'shipped', merchant_id: merchant2.id, customer_id: customer.id)
    invoice2.invoice_items.create(item_id: item2.id, quantity: 200, unit_price: 100)
    invoice2.transactions.create(credit_card_number: '1234567812345678', result: 'success')

    invoice3 = Invoice.create(status: 'shipped', merchant_id: merchant3.id, customer_id: customer.id)
    invoice3.invoice_items.create(item_id: item3.id, quantity: 300, unit_price: 100)
    invoice3.transactions.create(credit_card_number: '1234567812345678', result: 'success')

    get '/api/v1/merchants/most_revenue?quantity=3'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)['data']

    expect(merchants[0]['attributes']['id']).to eq(merchant3.id)
    expect(merchants[1]['attributes']['id']).to eq(merchant2.id)
    expect(merchants[2]['attributes']['id']).to eq(merchant1.id)
  end
end
