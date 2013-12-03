class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :line_items
  has_many :products, :through => :line_items

  attr_accessible :customer_id, :gst_rate, :hst_rate, :pst_rate, :status


  validates :customer_id, :status, :presence => true
  validates :order, :inclusion => { :in => %w(paid pending shipped) }
end
