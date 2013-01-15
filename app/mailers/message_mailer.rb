class MessageMailer < ActionMailer::Base
  default from: "no-reply@codebiff.com"

  def new_message user, message
    @user = user
    @message = message
    @data = message.data
    mail(to: user.email, subject: "New message via Chloroform")
  end

end
