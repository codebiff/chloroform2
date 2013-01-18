class MessagesController < ApplicationController

  before_filter :authenticate_user!

  def index
  end

  def label
    @messages = current_user.messages.labeled(params[:slug])
  end

end
