class ProductsController < ApplicationController
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

    if params['category']

      @products = Product.joins(:category).where("categories.name LIKE ?", "%#{params[:keywords]}%")

    else

      @products = Product.where("name LIKE ? or description LIKE ?", "%#{params[:keywords]}%", "%#{params[:keywords]}%")

    end


  end




end
