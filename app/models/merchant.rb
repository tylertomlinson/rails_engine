class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :invoices, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.search_by_name(name)
    where("LOWER(name) LIKE ?", "%#{name.downcase}%").first
  end

  def self.search_all_by_name(name)
    where("LOWER(name) LIKE ?", "%#{name.downcase}%")
  end
end
