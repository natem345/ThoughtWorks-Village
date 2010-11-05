class MenteeProfilesController < ApplicationController
  def read
  end

  def delete
    if params[:delete]
      redirect_to "/" 
    end
  end

  def update_general
    if params[:mentee]
      flash[:status]="Profile updated"
    end
  end

  def update_sw
  end

  def update_nonsw
  end

end
