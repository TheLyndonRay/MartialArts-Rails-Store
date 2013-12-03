class PagesController < ApplicationController
  def index

    session[:items] ||= []
    @cart = []
    session[:items].each {|id| @cart << Product.find(id)}

  end

  def about

    @page = Page.where("title = 'about'").first

  end

  def contact

    @page = Page.where("title = 'contact'").first

  end
end
