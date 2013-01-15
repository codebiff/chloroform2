class ApiController < ApplicationController

  def submit
    @user = User.find_by_api_key(params[:api_key])
    Message.generate(@user, params)
    redirect_to root_path
  end

end
