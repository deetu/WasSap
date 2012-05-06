class UserMailer < ActionMailer::Base
  default :from => "Admin WaaSaap"
  def registration_confirmation (user)
    @user = user
    #attachments["rails.png"]= File.read("#{Rails.root}/app/assets/images/rails.png")
    mail(:to => "#{user.username} <#{user.email}>", :subject => "WaaSap Registration")
  end
  
  
end
