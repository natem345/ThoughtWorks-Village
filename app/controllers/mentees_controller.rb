class MenteesController < ApplicationController

  before_filter :authenticate, :except => [:index, :show, :new, :create]

  def authenticate
    if session[:id]==nil
      redirect_to '/users/login'
    end
  end

  # GET /mentees
  # GET /mentees.xml
  def index
    @mentees = Mentee.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mentees }
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

        format.html { redirect_to(@mentee, :notice => 'Mentee was successfully created.') }
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
        format.html { redirect_to(@mentee, :notice => 'Mentee was successfully updated.') }
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
      @mentee.destroy
      
      respond_to do |format|
        format.html { redirect_to(mentees_url) }
        format.xml  { head :ok }
      end
    end
  end
end
