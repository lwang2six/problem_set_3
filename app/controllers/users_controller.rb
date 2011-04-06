class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]

  def index
    @user = current_user
    @users = User.find_everyone(@user)
  end

  def home
    if current_user
      @user = current_user
      @chats = @user.chats
      render :action => 'show'
    else
      @seats = Seat.order("position").all
      if @seats.count == 0
        for i in 1..32
          @seat = Seat.create(:position => i)
        end

        redirect_to root_path
      else
        render :action=> 'seats/index'
      end
    end
  end

  def show
    begin 
      if params[:id]
        @user = User.find(params[:id])
      else
        @user = current_user
        @chats = @user.chats
      end
    rescue
      redirect_to users_path, :notice => 'No such user'
    end
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to(user_path(@user), :notice => 'User successfully added.')
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
