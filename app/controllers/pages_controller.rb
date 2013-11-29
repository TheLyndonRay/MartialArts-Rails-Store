class PagesController < ApplicationController
  def index
  end

  def about

    @page = Page.where("title = 'about'").first

  end

  def contact

    @page = Page.where("title = 'contact'").first

  end
end
