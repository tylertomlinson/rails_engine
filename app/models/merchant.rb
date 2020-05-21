class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :invoices, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  # has_many :transactions, through: :items

  def self.search_by_name(name)
    find_by('LOWER(name) LIKE ?', "%#{name.downcase}%")
  end

  def self.search_all_by_name(name)
    where('LOWER(name) LIKE ?', "%#{name.downcase}%")
  end

  def self.most_revenue(limit)
    joins(invoice_items: :transactions)
      .group(:id)
      .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS total_revenue')
      .merge(Transaction.successful)
      .order(total_revenue: :desc)
      .limit(limit)
  end
end
