class DashboardController < ApplicationController

  before_filter :authenticate_user!

  def index
    @messages = current_user.messages
    @labels = @messages.map{|m| {m.label["name"] => m.label["slug"]} }.uniq
  end

end
