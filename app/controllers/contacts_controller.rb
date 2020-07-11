class ContactsController < ApplicationController
    layout "picto_edition_home", only: [:index]

    # disable the filter for for all actions in this controller
    before_filter :disable_filter_pict_home!

    def index
        @edition = Edition.find( params[:id] )
        #here we have to load Contacts belongs to this edition @edition.contacts
        @contacts = Contact.all
    end

end