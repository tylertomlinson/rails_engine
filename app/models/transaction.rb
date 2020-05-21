class Transaction < ApplicationRecord
  validates :credit_card_number, presence: true
  validates :result, presence: true
  has_many :merchants, through: :items
  belongs_to :invoice

  scope :successful, -> { where(result: 'success') }
end
