class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]

  def index
    @users = User.all
  end
  def show
    authenticate
    @user = User.first
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to user_path(@user), :notice => 'User successfully added.'
    else
      render :action => 'new'
    end
  end

  def edit
    authenticate
    @user = current_user
  end
 
  def update
    authenticate
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to(user_path(@user), :notice => 'Update user information successfully.')
    else
      render :action => 'edit'
    end
  end
end
