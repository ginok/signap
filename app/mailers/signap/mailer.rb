class Signap::Mailer < ActionMailer::Base
  default from: 'signap@example.com'

  def confirmation_instructions(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Signap')
  end
end
