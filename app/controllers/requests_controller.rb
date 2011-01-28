class RequestsController < ApplicationController

  before_filter :authenticate

  def authenticate
	if session[:id]==nil
	  redirect_to '/users/login'
	end
  end
  # GET /requests
  # GET /requests.xml
  def index
    @requests = Request.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @requests }
    end
  end

  # GET /requests/1
  # GET /requests/1.xml
  def show
    @request = Request.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @request }
    end
  end

  # POST /requests
  # POST /requests.xml
  def create
    @mentor = Mentor.find(params[:mentor_id])
    @request = @mentor.requests.create(params[:request])
	@request.mentee=Mentee.find(2)
	@request.save
    redirect_to(@mentor, :notice => "Request was sent.")
  end

  # PUT /requests/1
  # accepts request
  def update
    @request = Request.find(params[:id])
	@mentorship=Mentorship.new
	@mentorship.mentor=@request.mentor
	@mentorship.mentee=@request.mentee
	@mentorship.save

	redirect_to(@mentorship.mentor, :notice => "Meet your new mentor")
    @request.destroy
  end

  # DELETE /requests/1
  # DELETE /requests/1.xml
  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    respond_to do |format|
      format.html { redirect_to(requests_url) }
      format.xml  { head :ok }
    end
  end

end
