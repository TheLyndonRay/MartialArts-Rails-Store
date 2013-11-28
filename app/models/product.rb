class Product < ActiveRecord::Base
  has_many :orders
  has_many :line_items
  belongs_to :category

  attr_accessible :description, :name, :price, :stock_quantity, :image, :category_id

  validates :name, :price, :stock_quantity, :category_id, :presence => true
end
