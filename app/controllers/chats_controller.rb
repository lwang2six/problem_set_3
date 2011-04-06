class ChatsController < ApplicationController
  before_filter :authenticate
  # GET /chats
  # GET /chats.xml
  def index
    authenticate
    @user = current_user
    @users = User.find_everyone(@user)
    @chats = @user.chats

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @chats }
    end
  end

  # GET /chats/1
  # GET /chats/1.xml
  def show
    @chat = current_user.chats.find(params[:id])
    @messages = Message.find_all_by_chat_id(@chat)
    @message = Message.new
    @user = current_user
 
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chat }
    end
  end

  # GET /chats/new
  # GET /chats/new.xml
  def new
    @user = current_user
    @chat = Chat.new
    @message = Message.new
    if params[:id]
      @other = User.find(params[:id])
    else
      @other = false
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @chat }
    end
  end

  # POST /chats
  # POST /chats.xml
  def create
    @chat = Chat.new(params[:chat])
    @user = current_user
   
    @other = User.find_by_email(params[:user2])

    respond_to do |format|
      if @other
        if @chat.save
          @message = Message.create(:msg => params[:message])
          @message.user = @user
          @chat.messages << @message
          @chat.users << @other
          @chat.users << @user 
          format.html { redirect_to(chat_path(@chat), :notice => 'Chat was successfully created.') }
          format.xml  { render :xml => chat_path(@chat), :status => :created, :location => @chat }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @chat.errors, :status => :unprocessable_entity }
        end
      else
        @chat.errors.add(:user, "cannot be empty")
        format.html { render :action => "new" }
        format.xml  { render :xml => @chat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /chats/1
  # DELETE /chats/1.xml
  def destroy
    @chat = Chat.find(params[:id])
    if @chat.users.count > 1
      @chat.users.delete(current_user)
    else
      @chat.messages.each do |msg|
        msg.destroy
      end
      @chat.destroy
    end
    respond_to do |format|
      format.html { redirect_to(chats_url) }
      format.xml  { head :ok }
    end
  end
end
