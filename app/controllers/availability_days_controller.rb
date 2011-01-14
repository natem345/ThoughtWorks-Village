class AvailabilityDaysController < ApplicationController
  # GET /availability_days
  # GET /availability_days.xml
  def index
    @availability_days = AvailabilityDay.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @availability_days }
    end
  end

  # GET /availability_days/1
  # GET /availability_days/1.xml
  def show
    @availability_day = AvailabilityDay.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @availability_day }
    end
  end

  # GET /availability_days/new
  # GET /availability_days/new.xml
  def new
    @availability_day = AvailabilityDay.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @availability_day }
    end
  end

  # GET /availability_days/1/edit
  def edit
    @availability_day = AvailabilityDay.find(params[:id])
  end

  # POST /availability_days
  # POST /availability_days.xml
  def create
    @availability_day = AvailabilityDay.new(params[:availability_day])

    respond_to do |format|
      if @availability_day.save
        format.html { redirect_to(@availability_day, :notice => 'Availability day was successfully created.') }
        format.xml  { render :xml => @availability_day, :status => :created, :location => @availability_day }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @availability_day.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /availability_days/1
  # PUT /availability_days/1.xml
  def update
    @availability_day = AvailabilityDay.find(params[:id])

    respond_to do |format|
      if @availability_day.update_attributes(params[:availability_day])
        format.html { redirect_to(@availability_day, :notice => 'Availability day was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @availability_day.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /availability_days/1
  # DELETE /availability_days/1.xml
  def destroy
    @availability_day = AvailabilityDay.find(params[:id])
    @availability_day.destroy

    respond_to do |format|
      format.html { redirect_to(availability_days_url) }
      format.xml  { head :ok }
    end
  end
end
