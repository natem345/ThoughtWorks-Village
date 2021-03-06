require 'date'

class AvailabilityCalendarsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show ]

  def authenticate
	if session[:id]==nil
	  redirect_to '/users/login'
	end
  end


  def update_day
	availDate=Date.parse(params[:date])
	@availability_calendar = User.find(session[:id]).availability_calendar
	currentDay = @availability_calendar.availability_days.where(:availability_day => availDate).first
	if currentDay.nil? #day doesn't exist yet
		@availability_calendar.availability_days.build(:availability_day => availDate, :availability => params[:color]).save
	else
		currentDay.availability=params[:color]
		currentDay.save
	end
	if User.find(session[:id]).availability_calendar.save
		render :text => "Updated availability for date " + availDate.to_s() + " to " + params[:color]
	else
		render :text => "<strong>Failure</strong> updating date " + availDate.to_s() + " to " + params[:color]
	end
  end


  # GET /availability_calendars
  # GET /availability_calendars.xml
  def index
	redirect_to new_availability_calendar_path
  end
  def search
	return "successs"
  end
  # GET /availability_calendars/1
  # GET /availability_calendars/1.xml
  def show
	redirect_to new_availability_calendar_path
  end

  # GET /availability_calendars/new
  # GET /availability_calendars/new.xml
  def new
	@availability_calendar = User.find(session[:id]).availability_calendar
	if User.find(session[:id]).availability_calendar.nil?:
	  User.find(session[:id]).availability_calendar=AvailabilityCalendar.create
	  if User.find(session[:id]).availability_calendar.nil?:
		redirect_to "http://google.com"
	  end
	  #@availability_calendar = User.find(session[:id]).availability_calendar
	  #14.times {	|i|
		#@availability_calendar.availability_days.build(:availability_day => Date.today+i.days)
	  #}
	  User.find(session[:id]).availability_calendar.save
	end
    #@availability_calendar = User.find(session[:id]).availability_calendar
	#redirect_to (:action => 'edit', :id => @availability_calendar.id)# edit_availability_calendar @availability_calendar
  end


  # GET /availability_calendars/1/edit
  def edit
    @availability_calendar = AvailabilityCalendar.find(params[:id])
	
  end

  # POST /availability_calendars
  # POST /availability_calendars.xml
  def create
    @availability_calendar = AvailabilityCalendar.new(params[:availability_calendar])

    respond_to do |format|
      if @availability_calendar.save
        format.html { redirect_to(@availability_calendar, :notice => 'Availability calendar was successfully created.') }
        format.xml  { render :xml => @availability_calendar, :status => :created, :location => @availability_calendar }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @availability_calendar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /availability_calendars/1
  # PUT /availability_calendars/1.xml
  def update
    @availability_calendar = AvailabilityCalendar.find(params[:id])

    respond_to do |format|
      if @availability_calendar.update_attributes(params[:availability_calendar])
        format.html { redirect_to(@availability_calendar, :notice => 'Availability calendar was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @availability_calendar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /availability_calendars/1
  # DELETE /availability_calendars/1.xml
  def destroy
    @availability_calendar = AvailabilityCalendar.find(params[:id])
    @availability_calendar.destroy

    respond_to do |format|
      format.html { redirect_to(availability_calendars_url) }
      format.xml  { head :ok }
    end
  end
end
