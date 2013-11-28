class Product < ActiveRecord::Base
  has_many :orders
  has_many :line_items

  attr_accessible :description, :name, :price, :stock_quantity, :image

  validates :name, :price, :stock_quantity, :presence => true
end
