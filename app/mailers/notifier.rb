class Notifier < ActionMailer::Base
  default :from => "village@thoughtworks.com"
  
  def welcome_email(user)
	@user = user
    @url  = "http://thoughtworks-village.heroku.com/"
    mail(:to => @user.email,
         :subject => "Welcome to ThoughtWorks Village")
  end 
  
  def mentorship_request_email(request)
    @request = request
    @url  = "http://thoughtworks-village.heroku.com/"
    mail(:to => @request.mentor.email,
         :subject => "Pending Mentorship Request")
  end
  
  def mentorship_accepted_email(request)
    @request = request
    @url  = "http://thoughtworks-village.heroku.com/"
    mail(:to => @request.mentee.email,
         :subject => "Mentorship Request: Confirmed")
  end
  
  def mentorship_rejected_email(request)
    @request = request
    @url  = "http://thoughtworks-village.heroku.com/"
    mail(:to => @request.mentee.email,
         :subject => "Mentorship Request: Rejected")
  end
end
