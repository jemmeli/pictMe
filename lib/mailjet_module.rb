module MailjetModule
    require 'mailjet'

    
    def get_all_campaigns
        Mailjet.configure do |config|
            config.api_key = ENV['MJ_APIKEY_PUBLIC']
            config.secret_key = ENV['MJ_APIKEY_PRIVATE']
            config.api_version = "v3.1"
        end
        #Get All Campaign belong to current user
        variable_liste = Mailjet::Campaign.all({From: current_user.email})
        #binding.pry
        #@variable_liste =  variable_liste.attributes['Data']
        #current_user.email
    end

end