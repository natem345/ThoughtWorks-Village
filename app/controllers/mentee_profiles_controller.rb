class MenteeProfilesController < ApplicationController
before_filter :authenticate, :except => [:read, :search]

  def read
  end


  def delete
	if params[:delete]
      	redirect_to "/"
      	session[:usertype]=nil
	end
end

  def update_general
	if params [:user]
	    flash[:status]="Profile updated"
    	
  	end
  end
  def update_sw
  end

  def update_nonsw
  end

end
