class MenteesController < ApplicationController

  before_filter :authenticate, :except => [:index, :show, :new, :create]

  def authenticate
    if session[:id]==nil
      redirect_to '/users/login'
    end
  end

 
  def index
    @query = params
    @skills = []
    @abilities = ["Skills:"]
    @locations = ["Locations:"]
    @filterables = []
    @checked = ["default"]
    

    if params[:utf8] != nil     
      params.each do |p|
        if p.first[0,3] == "Ski"
          @abilities << p.second
        elsif p.first[0,3] == "Loc"
          @locations << p.second
        end         
      end 
    
      @checked = @locations + @abilities

        @abilities.each do |a|
         @skills = @skills + Skill.where("title = ?", a)         
        end   

        @skills.each do |e|
            if @mentees == nil
              @mentees = Mentee.where("id = ?", e.user_id)
            else
              @mentees = @mentees & Mentee.where("id = ?", e.user_id)
            end
        end

       if @locations.second != nil
         @mentees = @mentees & Mentee.where("location = ?", @locations.second)
       end

     
    else
      @mentees = Mentee.all
      @skills = Skill.all
      @skills.each do |e|
        @abilities << e.title
      end
      
    end

    if(@mentees != [] )
      @mentees.each do |m| 
        @locations << m.location        
     end
      @locations =@locations & @locations
	end                 
  

    @filterables << @abilities  << @locations  

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mentors }
  end
  end


  # GET /mentees/1
  # GET /mentees/1.xml
  def show
    @mentee = Mentee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mentee }
    end
  end

  # GET /mentees/new
  # GET /mentees/new.xml
  def new
    @mentee = Mentee.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mentee }
    end
  end

  # GET /mentees/1/edit
  def edit
    if session[:id].to_s == params[:id].to_s
      @mentee = Mentee.find(params[:id])
    else
      redirect_to '/mentees', :notice => 'You may only edit your own profile.'
    end
  end

  # POST /mentees
  # POST /mentees.xml
  def create
    @mentee = Mentee.new(params[:mentee])

    respond_to do |format|
      if @mentee.save

        @newuser = User.where(:id => @mentee.id).first
        Notifier.welcome_email(@newuser).deliver

		#login user so they can edit skills
    	session[:id] = @mentee.id # Remember the user's id during this session 
        session[:usertype] = :mentee

        format.html { redirect_to(skills_path, :notice => 'Your mentee account was successfully created!') }
        format.xml  { render :xml => @mentee, :status => :created, :location => @mentee }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mentee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mentees/1
  # PUT /mentees/1.xml
  def update
    @mentee = Mentee.find(params[:id])
    
    respond_to do |format|
      if @mentee.update_attributes(params[:mentee])
        format.html { redirect_to(skills_path, :notice => 'Profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mentee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mentees/1
  # DELETE /mentees/1.xml
  def destroy
    if session[:id].to_s == params[:id].to_s
      @mentee = Mentee.find(params[:id])

      #Delete Requests
      Request.where(:mentee_id => params[:id]).each do |r|
        r.destroy
      end

      #Delete Mentorships
      Mentorship.where(:mentee_id => params[:id]).each do |m|
        m.destroy
      end

      #Delete Experiences
      Skill.where(:user_id => params[:id]).each do |s|
        s.destroy
      end

#      # Disabled and untested, we might want to keep survey data
#      #Delete Surveys, Questions and Responses
#      Survey.where(:user_id => params[:id]).each do |s|
#        Question.where(:survey_id => s.id).each do |q|
#          Response.where(:question_id => q.id).each do |r|
#            r.destroy
#          end
#          q.destroy
#        end
#        s.destroy
#      end

      @mentee.destroy
      reset_session

      redirect_to '/users/login', :notice => "Logged out."
    else
      redirect_to '/mentees', :notice => 'You may only delete your own profile.'
    end
  end
end
