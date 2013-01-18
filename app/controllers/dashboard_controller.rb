class DashboardController < ApplicationController

  before_filter :authenticate_user!

  def index
    @messages = current_user.messages
    @labels = Message.get_labels(@messages)
  end

end
