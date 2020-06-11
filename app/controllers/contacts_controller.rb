class ContactsController < ApplicationController
    layout "picto_edition_home", only: [:index]

    def index
        @edition = Edition.find( params[:id] )
        #here we have to load Contacts belongs to this edition @edition.contacts
        @contacts = Contact.all
    end

end