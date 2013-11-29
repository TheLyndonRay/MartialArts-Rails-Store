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


end
