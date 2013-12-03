class ProductsController < ApplicationController
  before_filter :start_cart


  def index

    @products = Product.order('id')

  end

  def show

    @product = Product.find(params[:id])

  end

  def kicks

    @products = Product.joins(:category).where("categories.name = 'Kick'")

  end

  def punches

    @products = Product.joins(:category).where("categories.name = 'Punch'")

  end

  def blocks

    @products = Product.joins(:category).where("categories.name = 'Block'")

  end

  def search

  end

  def results

    if params['category'] == ''

      @products = Product.where("name LIKE ? or description LIKE ?", "%#{params[:keywords]}%", "%#{params[:keywords]}%")

    else

      @products = Product.joins(:category).where("categories.id LIKE ? and products.name LIKE ?", "%#{params['category']}%", "%#{params[:keywords]}%")

    end


  end

  def add_to_cart

    id = params[:id].to_i
    session[:items] << id unless session[:items].include?(id)
    redirect_to :action => :index

  end

  def remove_from_cart

    id = params[:id].to_i
    session[:items].delete(id)
    redirect_to :action => :index

  end

  def start_checkout

  end

  def finish_checkout

    @customer = Customer.new
    @customer.first_name = params[:customer][:first_name]
    @customer.last_name = params[:customer][:last_name]
    @customer.address = params[:customer][:address]
    @customer.city = params[:customer][:city]
    @customer.postal_code = params[:customer][:postal_code]
    @customer.email = params[:customer][:email]
    @customer.province_id = params[:customer][:province_id]

    if @customer.save

      @order = @customer.orders.build
      @order.status = 'pending'
      @order.pst_rate = @customer.province.pst
      @order.gst_rate = @customer.province.gst
      @order.hst_rate = @customer.province.hst
      @order.save

      session[:items].each do |id|
        product = Product.find(id)
        line_item = @order.line_items.build
        line_item.product = product
        line_item.price = product.price
        product.stock_quantity -= 1
        product.save
        line_item.save
      end

    end

  end




protected

  def start_cart

    session[:items] ||= []
    @cart = []
    session[:items].each {|id| @cart << Product.find(id)}

  end

end
