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

      @products = Product.joins(:category).where("categories.id LIKE ?", "%#{params['category']}%").where("products.name LIKE ? or products.description LIKE ?", "%#{params[:keywords]}%", "%#{params[:keywords]}%")

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

    @customer = Customer.new
    @provinces = Province.all

  end

  def view_cart

    @products = @cart

  end

  def finish_checkout

    @customer = Customer.new(params[:customer])
    #@customer.first_name = params[:customer][:first_name]
    #@customer.last_name = params[:customer][:last_name]
    #@customer.address = params[:customer][:address]
    #@customer.city = params[:customer][:city]
    #@customer.postal_code = params[:customer][:postal_code]
    #@customer.email = params[:customer][:email]
    #@customer.province_id = params[:customer][:province_id]

    if @customer.save

      @order = @customer.orders.build
      @order.status = 'pending'
      @order.pst_rate = @customer.province.pst
      @order.gst_rate = @customer.province.gst
      @order.hst_rate = @customer.province.hst
      @order.save


      @sub_total = 0

      session[:items].each do |id|
        product = Product.find(id)
        line_item = @order.line_items.build
        line_item.product = product
        line_item.price = product.price
        @sub_total += product.price
        line_item.quantity = 1
        product.stock_quantity -= 1
        product.save
        line_item.save
      end

      session[:items] = []
      individual_total = 0

      pst = @customer.province.pst
      gst = @customer.province.gst
      hst = @customer.province.hst

      pst_string_percentage = pst * 100
      gst_string_percentage = gst * 100
      hst_string_percentage = hst * 100

      pst_float = pst_string_percentage.to_f.round(2)
      gst_float = gst_string_percentage.to_f.round(2)
      hst_float = hst_string_percentage.to_f.round(2)

      total_with_pst = @sub_total * pst
      total_with_gst = @sub_total * gst
      total_with_hst = @sub_total * hst

      @taxes = total_with_pst + total_with_gst + total_with_hst

      @grand_total = @sub_total + @taxes

    else

     flash[:notice] = 'Something went wrong. Please try again.'

    end


  end




protected

  def start_cart

    session[:items] ||= []
    @cart = []
    session[:items].each {|id| @cart << Product.find(id)}

  end

end
