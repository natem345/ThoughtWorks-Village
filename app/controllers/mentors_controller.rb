class MentorsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show, :new, :create]

  def authenticate
	if session[:id]==nil
	  redirect_to '/users/login'
	end
  end
  # GET /mentors
  # GET /mentors.xml
  def index
    @mentors = Mentor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mentors }
    end
  end

  # GET /mentors/1
  # GET /mentors/1.xml
  def show
    @mentor = Mentor.find(params[:id])
	@availability_calendar=@mentor.availability_calendar
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mentor }
    end
  end

  # GET /mentors/new
  # GET /mentors/new.xml
  def new
    @mentor = Mentor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mentor }
    end
  end

  # GET /mentors/1/edit
  def edit
    @mentor = Mentor.find(params[:id])
  end

  # POST /mentors
  # POST /mentors.xml
  def create
    @mentor = Mentor.new(params[:mentor])

    respond_to do |format|
      if @mentor.save

        @newuser = User.where(:id => @mentor.id).first
        Notifier.welcome_email(@newuser).deliver

        format.html { redirect_to(@mentor, :notice => 'Mentor was successfully created.') }
        format.xml  { render :xml => @mentor, :status => :created, :location => @mentor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mentor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mentors/1
  # PUT /mentors/1.xml
  def update
    @mentor = Mentor.find(params[:id])

    respond_to do |format|
      if @mentor.update_attributes(params[:mentor])
        format.html { redirect_to(@mentor, :notice => 'Mentor was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mentor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mentors/1
  # DELETE /mentors/1.xml
  def destroy
    @mentor = Mentor.find(params[:id])
    @mentor.destroy

    respond_to do |format|
      format.html { redirect_to(mentors_url) }
      format.xml  { head :ok }
    end
  end
  
  def search
    @query = params[:q]
    #@mentors = Mentor.where("name = ?",@query)
    #cond_text   = @query.split.map{|w| "name LIKE ? "}.join(" OR ")
    #cond_values = @query.split.map{|w| "%#{w}%"}
    #@mentors = Mentor.all(:conditions =>  (@query ? [cond_text, *cond_values] : []))

    @mentors = Mentor.where("name = ?", @query)
    @mentors = @mentors | Mentor.where("location = ?", @query)
    @mentors = @mentors | Mentor.where("current_position = ?", @query)
    @mentors = @mentors | Mentor.where("school = ?", @query)
    @mentors = @mentors | Mentor.where("major = ?", @query)
    @mentors = @mentors | Mentor.where("total_years_experience = ?", @query)
    @mentors = @mentors | Mentor.where("interests = ?", @query)
                

    respond_to do |format|
      format.html # search.html.erb
      format.xml  { render :xml => @mentor }
    end
  end
  
end
