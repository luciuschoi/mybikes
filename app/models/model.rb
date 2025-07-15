class Model < ApplicationRecord
  belongs_to :brand
  
  validates :name, presence: true
  validates :year, numericality: { greater_than: 1900, less_than_or_equal_to: Date.current.year + 1 }
  validates :category, inclusion: { in: %w[motorcycle bicycle hybrid] }
  validates :price, numericality: { greater_than: 0, allow_nil: true }
  validates :engine_displacement, numericality: { greater_than: 0, allow_nil: true }
  validates :weight, numericality: { greater_than: 0, allow_nil: true }
  
  scope :motorcycles, -> { where(category: 'motorcycle') }
  scope :bicycles, -> { where(category: 'bicycle') }
  scope :hybrids, -> { where(category: 'hybrid') }
  scope :recent, -> { where('year >= ?', Date.current.year - 5) }
  scope :by_price_range, ->(min, max) { where(price: min..max) }
  
  def display_name
    "#{brand.name} #{name} (#{year})"
  end
  
  def price_formatted
    return '가격 정보 없음' if price.nil?
    ActionController::Base.helpers.number_to_currency(price, unit: '₩', precision: 0)
  end
end
