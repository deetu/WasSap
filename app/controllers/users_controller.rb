class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create, :search]
  def index
    @users = User.page(params[:page]).per(2)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
    
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Thank you for signing up! You are now logged in."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end
  
  def age
  @user = user
  now = Time.now.utc.to_date
  now.year - @user.dob.year - (@user.dob.to_date.change(:year => now.year) > now ? 1 : 0)
  end
  
  def search 
  if params[:key].blank?
   @users = []
  else
    @users = User.where(["username LIKE ?", "%#{params[:key]}%"]).order('username')
  end
  end
  
end
