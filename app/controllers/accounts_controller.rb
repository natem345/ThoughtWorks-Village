class AccountsController < ApplicationController
  def login
    if params[:user]
      if params[:user][:email]=="jsmith@thoughtworks.com"
        session[:usertype]=:mentor
      end
      
    end
  end

  def register
    redirect_to "google.com"
  end

  def forgot
  end
  def logout
    session[:usertype]=nil
  end
end
