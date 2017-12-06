class UserMailer <ActionMailer::Base
    default :from => 'noreply@itinerarybuilder2017.com'
    
    def registration_confirmation(user)
        @user = user
        mail(:to => "#{user.name} <#{user.email}>", :subject => "Please confirm your registration")
    end 
end