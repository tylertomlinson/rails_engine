require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
  end

  describe 'search_by_name' do
    it 'can find merchant case insensitive' do
      merchant1 = create(:merchant, name: 'tyler')

      result = Merchant.search_by_name('TYLER')
      expect(result).to eq(merchant1)
    end
  end

  describe 'search_all_by_name' do
    it 'can find all merchants with name case insensitive' do
      @merchant1 = create(:merchant, name: 'tyler')
      @merchant2 = create(:merchant, name: 'tyler')
      @merchant3 = create(:merchant, name: 'tyler tomlinson')
      @merchant4 = create(:merchant, name: 'bill')

      found = Merchant.search_all_by_name('TYLER')
      expect(found).to eq([@merchant1, @merchant2, @merchant3])
    end
  end
end
