class PagesController < ApplicationController
  def home
    @title="Home"
    @tinypost=Tinypost.new if signed_in?
  end

  def contact
    @title="Contact"
  end
  
  def about
    @title="About"
  end
  
  def support
    @title="Support"
  end
  
end
