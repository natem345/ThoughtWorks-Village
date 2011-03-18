class MentorshipsController < ApplicationController

  before_filter :authenticate

  def authenticate
    if session[:id]==nil
      redirect_to '/users/login'
    end
  end

  # GET /mentorships
  # GET /mentorships.xml
  def index
    @mentorships = Mentorship.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mentorships }
    end
  end

  # GET /mentorships/1
  # GET /mentorships/1.xml
  def show
    @mentorship = Mentorship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mentorship }
    end
  end

  # GET /mentorships/new
  # GET /mentorships/new.xml
  def new
    @mentorship = Mentorship.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mentorship }
    end
  end

  # GET /mentorships/1/edit
  def edit
    @mentorship = Mentorship.find(params[:id])
  end

  # POST /mentorships
  # POST /mentorships.xml
  def create
    @mentorship = Mentorship.new(params[:mentorship])

    respond_to do |format|
      if @mentorship.save
        format.html { redirect_to(@mentorship, :notice => 'Mentorship was successfully created.') }
        format.xml  { render :xml => @mentorship, :status => :created, :location => @mentorship }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mentorship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mentorships/1
  # PUT /mentorships/1.xml
  def update
    @mentorship = Mentorship.find(params[:id])

    respond_to do |format|
      if @mentorship.update_attributes(params[:mentorship])
        format.html { redirect_to(@mentorship, :notice => 'Mentorship was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mentorship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mentorships/1
  # DELETE /mentorships/1.xml
  def destroy
    @mentorship = Mentorship.find(params[:id])
    @mentorship.destroy

    respond_to do |format|
      format.html { redirect_to(mentorships_url) }
      format.xml  { head :ok }
    end
  end
end
