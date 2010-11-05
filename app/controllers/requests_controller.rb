class RequestsController < ApplicationController
  def make
    if params[:request]
      redirect_to "/mentor_profiles/read"
    end
  end

  def view
    if params[:request]
      redirect_to "/mentor_profiles/read"
    end
  end

end
