class AvailabilityCalendarsController < ApplicationController
  # GET /availability_calendars
  # GET /availability_calendars.xml
  def index
    @availability_calendars = AvailabilityCalendar.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @availability_calendars }
    end
  end

  # GET /availability_calendars/1
  # GET /availability_calendars/1.xml
  def show
    @availability_calendar = AvailabilityCalendar.find(params[:id])
	
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @availability_calendar }
    end
  end

  # GET /availability_calendars/new
  # GET /availability_calendars/new.xml
  def new
    @availability_calendar = AvailabilityCalendar.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @availability_calendar }
    end
  end

  # GET /availability_calendars/1/edit
  def edit
    @availability_calendar = AvailabilityCalendar.find(params[:id])
	3.times { |i|
	ad=@availability_calendar.availability_days.build 
	ad.availability_day=DateTime.now
	ad.availability_day+=i}  
	
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
