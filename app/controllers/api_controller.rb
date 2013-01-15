class ApiController < ApplicationController

  def submit
    if @user = User.find_by_api_key(params[:api_key])
      if m = Message.generate(@user, params)
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

end
