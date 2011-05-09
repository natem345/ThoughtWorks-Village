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
         :subject => "Mentorship Request: Pending")
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

  def forgot_password_email(user, passrequest)
    @user = user
    @passrequest = passrequest
    @url = "http://thoughtworks-village.heroku.com/"
    mail(:to => @user.email,
         :subject => "ThoughtWorks Password Reset Request")
  end

  def new_password_email(user)
    @user = user
    @url = "http://thoughtworks-village.heroku.com/"
    mail(:to => @user.email,
         :subject => "Your New ThoughtWorks Password")
  end
end
