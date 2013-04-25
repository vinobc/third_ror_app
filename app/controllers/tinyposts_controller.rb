class TinypostsController < ApplicationController
  
  before_filter :authenticate
  before_filter :authorized_user, :only=>:destroy
  
  def create
    @tinypost=current_user.tinyposts.build(params[:tinypost])
    if @tinypost.save 
      redirect_to root_path, :flash=>{:success=>"post created!"}
    else
      @feed_items=current_user.feed.paginate(:page=>params[:page])
      render 'pages/home'
    end
  end
  
  def destroy
    @tinypost.destroy
    redirect_to root_path, :flash=>{:success=>"post removed!"}
  end
  
  private
  
    def authorized_user
      @tinypost=Tinypost.find(params[:id])
      redirect_to root_path unless current_user?(@tinypost.user)
    end
  
end
  