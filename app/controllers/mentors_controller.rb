class MentorsController < ApplicationController

  before_filter :authenticate, :except => [:index, :show, :new, :create, :search]

  def authenticate
    if session[:id]==nil
      redirect_to '/users/login'
    end
  end

  # GET /mentors
  # GET /mentors.xml
  def index
    @query = params 
    @skills = []
    @abilities = ["Skills:"]
    @locations = ["Locations:"]
    @current_positions = ["Current Positions:"]   
    @filterables = []
    @checked=["this isn't nil"]    
   
   
    if params[:utf8] != nil      
      params.each do |p|
        if p.first[0,3] == "Ski"
          @abilities << p.second
        elsif p.first[0,3] == "Loc"
          @locations << p.second
        elsif p.first[0,3] == "Cur"
          @current_positions << p.second
        end
      end
        
      @checked = @locations + @abilities + @current_positions
      
      @i = 0
      @abilities.each do |a|         
        if a != "Skills:"
          toAdd = Skill.where("title = ?",a)
          if toAdd != []
            @skills[@i] = Skill.where("title = ?", a)
            @i += 1
          end
        end          
      end               
      
      #skills to mentors
      @j =0
      
      @skills.each do |s|
        replacement = []        
        s.each do |e|
          replacement = replacement + Mentor.where("id = ?", e.user_id)
        end
        @skills[@j] = replacement
        @j += 1       
      end
      
      
      @q = 0
      @skills.each do |s|
        if @mentors == nil
          @mentors = @skills[@q]
        else
          @mentors = @mentors & @skills[@q]
        end
        @q +=1
      end      
      
      
      if @locations.second != nil
        if @mentors != nil
          @mentors = @mentors & Mentor.where("location = ?", @locations.second)
        else
          @mentors = Mentor.where("location = ?", @locations.second)
        end
      end
      
      if @current_positions.second != nil
        if @mentors != nil
          @mentors = @mentors & Mentor.where("current_position = ?", @current_positions.second)
        else
          @mentors = Mentor.where("current_position = ?",@current_positions.second)
        end
      end
      
      
    else
      @mentors = Mentor.all
      @skills = Skill.all
      @skills.each do |e|
        @abilities << e.title
      end
      @abilities = @abilities & @abilities
      
    end
                    
    if(@mentors != nil )
      @mentors.each do |m|     

        @locations << m.location
        @current_positions << m.current_position
            
        @locations = @locations & @locations
        @current_positions = @current_positions & @current_positions
        Skill.where("user_id = ?", m.id).each do |t|
          @abilities << t.title
        end
       @abilities = @abilities & @abilities 
      
      end
	end

    @filterables << @abilities  << @locations << @current_positions 

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mentors }
    end
  end

  # GET /mentors/1
  # GET /mentors/1.xml
  def show
    @mentor = Mentor.find(params[:id])
    @availability_calendar = @mentor.availability_calendar
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
    if session[:id].to_s == params[:id].to_s
      @mentor = Mentor.find(params[:id])
    else
      redirect_to '/mentors', :notice => 'You may only edit your own profile.'
    end
  end

  # POST /mentors
  # POST /mentors.xml
  def create
    @mentor = Mentor.new(params[:mentor])

    respond_to do |format|
      if @mentor.save
        
        @newuser = User.where(:id => @mentor.id).first
        Notifier.welcome_email(@newuser).deliver

		#login user so they can edit skills
    	session[:id] = @mentor.id # Remember the user's id during this session 
        session[:usertype] = :mentor

        format.html { redirect_to(skills_path, :notice => 'Your mentor account was successfully created!') }
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
        format.html { redirect_to(skills_path, :notice => 'Profile was successfully updated.') }
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
    if session[:id].to_s == params[:id].to_s
      @mentor = Mentor.find(params[:id])
      
      #Delete Requests
      Request.where(:mentor_id => params[:id]).each do |r|
        r.destroy
      end
      
      #Delete Mentorships
      Mentorship.where(:mentor_id => params[:id]).each do |m|
        m.destroy
      end
      
      #Delete Skills
      Skill.where(:user_id => params[:id]).each do |e|
        e.destroy
      end

      # Disabled and untested, we might want to keep survey data
      #Delete Surveys, Questions and Responses
      #Survey.where(:user_id => params[:id]).each do |s|
        #Question.where(:survey_id => s.id).each do |q|
          #Response.where(:question_id => q.id).each do |r|
            #r.destroy
          #end
          #q.destroy
        #end
        #s.destroy
      #end

      #Delete AvailabilityCalendars
      AvailabilityCalendar.where(:mentor_id => params[:id]).each do |c|
        #Delete AvailabilityDays
        AvailabilityDay.where(:availability_calendar_id => c.id).each do |d|
          d.destroy
        end
        c.destroy
      end
      
      @mentor.destroy
      reset_session
      
      redirect_to '/users/login', :notice => "Logged out."
    else
      redirect_to '/mentors', :notice => 'You may only delete your own profile.'
    end
  end
  
  def search
    @query = params[:q]
    queryWords = @query.split
    @mentors =[]
   
    queryWords.each do |q|
      skills = Skill.where("title LIKE :query",{:query => "%#{q}%"})    
      skills.each do |e|
        @mentors = @mentors | Mentor.where("id = ?",e.user_id)
      end      
      
      @mentors = @mentors | Mentor.where("name LIKE :query",{:query => "%#{q}%"})     
      @mentors = @mentors | Mentor.where("location LIKE :query",{:query => "%#{q}%"})
      @mentors = @mentors | Mentor.where("current_position LIKE :query",{:query => "%#{q}%"})

    end
    
    #do something with availability
    
    respond_to do |format|
      format.html # search.html.erb
      format.xml  { render :xml => @mentor }
    end
  end
end
