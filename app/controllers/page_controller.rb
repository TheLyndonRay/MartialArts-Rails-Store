class PageController < ApplicationController

  def index

  end

  def about

    @page = Page.where("title = 'about'")

  end

  def contact

    @page = Page.where("title = 'contact'")

  end

end
