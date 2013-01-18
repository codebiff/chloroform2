class MessagesController < ApplicationController

  before_filter :authenticate_user!

  def index
  end

  def label
    @messages = current_user.messages.labeled(params[:slug])
    if ! @messages.empty?
    else
      redirect_to dashboard_path, alert: "No label with that name"
    end
  end

end
