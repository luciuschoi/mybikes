class Brand < ApplicationRecord
  has_many :models, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
  validates :founded_year, numericality: { greater_than: 1800, allow_nil: true }
  validates :category, inclusion: { in: %w[motorcycle bicycle hybrid], allow_nil: true }
  
  scope :motorcycles, -> { where(category: 'motorcycle') }
  scope :bicycles, -> { where(category: 'bicycle') }
  scope :hybrids, -> { where(category: 'hybrid') }
  
  def display_name
    "#{name} (#{country})"
  end
end
