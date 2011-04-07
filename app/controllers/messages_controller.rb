class MessagesController < ApplicationController
  before_filter :authenticate

=begin
  # GET /messages
  # GET /messages.xml
  def index
    @messages = Message.all
    @chat = Chat.find(params[:chat_id])
    @user = current_user
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @user = current_user
    @chat = Chat.find(params[:chat_id])
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new
    @chat = Chat.find(params[:chat_id])
    @user = current_user
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end
=end
  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])
    @user = current_user
    @chat = Chat.find(params[:chat_id])
    respond_to do |format|
      if @message.save
        @message.user = @user
        @chat.messages << @message
        if not @chat.users.include?(@user)
          @chat.users << @user
        end
        format.html { redirect_to(chat_path(@chat.id), :notice => 'Message was successfully created.') }
      else
        session[:message_error] = "cannot be empty"
        format.html { redirect_to(chat_path(@chat)) }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to(@message, :notice => 'Message was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end
end
