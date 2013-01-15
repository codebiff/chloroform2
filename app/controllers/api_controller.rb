class ApiController < ApplicationController

  def submit
    if @user = User.find_by_api_key(params[:api_key])
      if m = Message.generate(@user, params, request.referer)
        redirect_to m.confirm_url
      else
        redirect_to :back
      end
    else
      redirect_to :back
    end
  end

end
