class SurveysController < ApplicationController
  def complete
    if params[:survey]        
        redirect_to "/"
    end
  end

end
