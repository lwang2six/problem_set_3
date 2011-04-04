class SeatsController < ApplicationController
  before_filter :authenticate, :except => [:show, :index]

  # GET /seats
  # GET /seats.xml
  def index
    @seats = Seat.order("position").all
    if @seats.count == 0
      for i in 1..32
        @seat = Seat.create(:position => i)
      end
      redirect_to seats_path
    else
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @seats }
      end
    end
  end

  # GET /seats/1
  # GET /seats/1.xml
  def show
    redirect = false
    @seat = Seat.find_by_position(params[:id])
    @user = current_user
    if @seat.nil?
      redirect = true
    end
    respond_to do |format|
      if redirect == true
        format.html { redirect_to(seats_path,  :notice => 'Seat does not exist in class, sorry') }
      else
        format.html # show.html.erb
        format.xml  { render :xml => @seat }
      end
    end
  end

  # PUT /seats/1
  # PUT /seats/1.xml
  def update
    @seat = Seat.find_by_position(params[:id])
    @user = current_user
    old_seat = 
    respond_to do |format|
        if @seat.user.nil?
          @user.seat = @seat
          format.html { redirect_to(@seat, :notice => 'Seat was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { redirect_to(seats_path, :notice => 'Seat is already taken!') }        
        end
    end
  end

end
