class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :products

  attr_accessible :customer_id, :gst_rate, :hst_rate, :pst_rate, :status

  validates :customer_id, :gst_rate, :hst_rate, :pst_rate, :status, :presence => true
end
