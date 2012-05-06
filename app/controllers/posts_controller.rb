class PostsController < ApplicationController
  def index
    @posts = Post.order("created_at DESC").page(params[:page]).per(4)
    @users = User.find(:all)
    #@user_id = current_user.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end

  def create
    @post = current_user.posts.create(:message => params[:message])
    @users = User.all
    
    
    #@users = User.find(:all)
    #@user.user_id = post.user_id
  
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path }
        format.js
      else
        flash[:notice] = "Message failed to save."
        format.html { redirect_to posts_path }
      end
    end
  end
  
  
end
