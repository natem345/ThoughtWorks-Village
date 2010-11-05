class MentorProfilesController < ApplicationController
  def read
  end

  def delete
    if params[:delete]
      redirect_to "/"
      session[:usertype]=nil
    end
  end

  def update_general
    if params[:mentor]
      flash[:status]="Profile updated"
    end
  end

  def update_sw
  end

  def update_nonsw
  end

  def update_availability
  end

  def search
  end

end
