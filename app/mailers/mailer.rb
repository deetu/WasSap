class Mailer < ActionMailer::Base
  #default from: "deetu02@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.invitation.subject
  #
  def invitation (invitation, signup_url)
    @invitation = invitation
    @signup_url = signup_url
    mail :to => "#{invitation.recipient_email}"
    mail :from => "#{invitation.sender.email}"
    invitation.update_attribute(:sent_at, Time.now)
    mail :body => "#{invitation.sender.username.capitalize},"" has invited you to join WasSapp, this is the fastest growing Social Network world "
  end
  
end

