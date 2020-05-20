namespace :send do
    #environement to load Rails Models
    #bundle exec rake send:users
    desc "send emails"
    task send: :environment do

        # Run:
        require 'mailjet'
        Mailjet.configure do |config|
        config.api_key = ENV['MJ_APIKEY_PUBLIC']
        config.secret_key = ENV['MJ_APIKEY_PRIVATE']
        config.api_version = "v3.1"
        end
        variable = Mailjet::Send.create(messages: [{
            'From'=> {
                'Email'=> ENV['SENDER_EMAIL'],
                'Name'=> 'Me'
            },
            'To'=> [
                {
                    'Email'=> ENV['RECIPIENT_EMAIL'],
                    'Name'=> 'You'
                }
            ],
            'Subject'=> 'My first Mailjet Email!',
            'TextPart'=> 'Greetings from Mailjet!',
            'HTMLPart'=> '<h3>Dear passenger 1, welcome to <a href=\'https://www.mailjet.com/\'>Mailjet</a>!</h3><br />May the delivery force be with you!'
        }]
        )
        p variable.attributes['Messages']
        puts "Email sent ..."


#bundle exec rake send:send
#[{"Status"=>"success", "CustomID"=>"", "To"=>[{"Email"=>"jemmeli84@gmail.com", "MessageUUID"=>"732fe377-9ef3-473a-8166-43985316095f", "MessageID"=>288230379609003794, "MessageHref"=>"https://api.mailjet.com/v3/REST/message/288230379609003794"}], "Cc"=>[], "Bcc"=>[]}]
#Email sent ...



    end
end