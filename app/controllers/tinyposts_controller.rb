class TinypostsController < ApplicationController
  
  before_filter :authenticate
  
  def create
    @tinypost=current_user.tinyposts.build(params[:tinypost])
    if @tinypost.save 
      redirect_to root_path, :flash=>{:success=>"post created!"}
    else
      render 'pages/home'
    end
  end
  
  def destroy
  end
  
end
  