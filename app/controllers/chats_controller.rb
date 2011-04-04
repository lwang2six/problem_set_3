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
    @chat = Chat.find(params[:id])
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
    @other = User.find(params[:id])
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
   
    @other = User.find( params[:user2])

    respond_to do |format|
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
    end
  end

  # DELETE /chats/1
  # DELETE /chats/1.xml
  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy

    respond_to do |format|
      format.html { redirect_to(chats_url) }
      format.xml  { head :ok }
    end
  end
end
