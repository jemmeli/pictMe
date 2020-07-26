class ImageUploader < Shrine
    # plugins and uploading logic
    #plugin :default_storage, cache: :cache, store: :upload
    
    #def generate_location(io, context)
        #"HD/#{super}" 
    #end

   
    #def generate_location(io, context)
        #type  = context[:record].class.name.downcase if context[:record]
        #style = context[:version] if context[:version]
        #name  = super # the default unique identifier
        #[type, style, name].compact.join("/")
    #end

end