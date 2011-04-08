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
    # @maj = params["Majors:"]
    @skills = []
    @abilities = ["Abilities:"]
    @locations = ["Locations:"]
    @current_positions = ["Current Positions:"]
    # @majors = ["Majors:"]
    @filterables = []    
    @mentors = []
    @mentors4 = []

    if params[:utf8] != nil      
      params.each do |p|
        if p.first[0,3] == "Abi"
          @abilities << p.second
        elsif p.first[0,3] == "Loc"
          @locations << p.second
        elsif p.first[0,3] == "Cur"
          @current_positions << p.second
        # elsif p.first[0,3] == "Maj"
          # @majors << p.second
        else
        end 
        
        @mentors1 = Mentor.where("location = ?", @locations.second)
        @mentors2 = Mentor.where("current_position = ?", @current_positions.second)
        # @mentors3 = Mentor.where("major = ?", @majors.second)
           
        @abilities.each do |a|
         @skills = Skill.where("title = ?", a)         
        end

        @skills.each do |e|
         @mentors4 = Mentor.where("id = ?",e.user_id)
        end
        
        if(@mentors1 != [])          
            @mentors = @mentors1
        end
        
         if(@mentors2 != [])
          if(@mentors != [])
            @mentors = @mentors & @mentors2
          else
            @mentors = @mentors2
          end
        end

# if(@mentors3 != [])
          # if(@mentors != [])
            # @mentors = @mentors & @mentors3
          # else
            # @mentors = @mentors3
          # end
        # end

        if(@mentors4 != [])
          if(@mentors != [])
            @mentors = @mentors & @mentors4
          else
            @mentors = @mentors4
          end
        end    
      end
    else
      @mentors = Mentor.all
      @skills = Skill.all
      @skills.each do |e|
        @abilities << e.title
      end

       # @abilities = @abilities & @abilities
    end
                    
    if(@mentors != [] )
      @mentors.each do |m|     

      @locations << m.location
      @current_positions << m.current_position
      # @majors << m.major
      
      @locations = @locations & @locations
      @current_positions = @current_positions & @current_positions

      # @majors = @majors & @majors
     end
	end

    @filterables << @abilities  << @locations << @current_positions #<< @majors 

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
        @mentors = Mentor.where("id = ?",e.user_id)
      end      
      
      #@mentors = @mentors | Mentor.where("interests LIKE :query",{:query => "%#{q}%"})      
      @mentors = @mentors | Mentor.where("name LIKE :query",{:query => "%#{q}%"})
      # @mentors = @mentors | Mentor.where("major LIKE :query",{:query => "%#{q}%"})
      # @mentors = @mentors | Mentor.where("school LIKE :query",{:query => "%#{q}%"})
      @mentors = @mentors | Mentor.where("location LIKE :query",{:query => "%#{q}%"})

    end
    
    #do something with availability
    
    respond_to do |format|
      format.html # search.html.erb
      format.xml  { render :xml => @mentor }
    end
  end
end
