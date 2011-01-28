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
