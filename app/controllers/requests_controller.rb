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
    if session[:usertype] == :mentor
      @requests = Request.where(:mentor_id => session[:id])
    elsif session[:usertype] == :mentee
      @requests = Request.where(:mentee_id => session[:id])
    else
      @requests = Request.all
    end

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
    @request = Request.new(params[:request])
    @request.mentor = Mentor.find(params[:mentor_id])
    @request.mentee = Mentee.find(session[:id])
    @mentor = @request.mentor

    if @request.save
      Notifier.mentorship_request_email(@request).deliver
      redirect_to(@mentor, :notice => "Your request has been sent.")
    else
      redirect_to(@mentor, :notice => "The request could not be sent.")
    end
  end

  # PUT /requests/1
  # Accepted Request
  def update
    @mentorship = Mentorship.new
    @request = Request.find(params[:id])
    @mentorship.mentor = @request.mentor
    @mentorship.mentee = @request.mentee
    
    if @mentorship.save
      Notifier.mentorship_accepted_email(@request).deliver
      redirect_to(@mentorship.mentee, :notice => "Meet your new mentee!")
      @request.destroy
    else
      redirect_to(@mentorship.mentee, :notice => "The request could not be confirmed.")
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.xml
  # Rejected Request
  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    
    Notifier.mentorship_rejected_email(@request).deliver
    
    respond_to do |format|
      format.html { redirect_to(requests_url) }
      format.xml  { head :ok }
    end
  end
end
