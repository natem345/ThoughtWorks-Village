class AccountsController < ApplicationController
  def login
    if params[:user]
      if params[:user][:email]=="jsmith@thoughtworks.com"
        session[:usertype]=:mentor
        redirect_to requests
        
      end
      if params[:user][:email]=="jdoe@aol.com"
        session[:usertype]=:mentee
        redirect_to mentors
      end      
    end
  end

  def register
    if params[:user]
      if params[:user][:email]=="jsmith@thoughtworks.com"
        session[:usertype]=:mentor
        redirect_to "/mentor_profiles/update_general"
      end
      if params[:user][:email]=="jdoe@aol.com"
        session[:usertype]=:mentee
        redirect_to "/mentee_profiles/update_general"
      end
    end
  end

  def forgot
  end
  def logout
    session[:usertype]=nil
    redirect_to "/"
  end
end
