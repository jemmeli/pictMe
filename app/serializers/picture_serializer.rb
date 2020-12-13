class PictureSerializer < ActiveModel::Serializer
  attributes :id, :image_data,:edition_id, :bib, :created_at, :updated_at, :owner_of_picture

  def owner_of_picture
    #owner_of_picture = Contact.where(dossard: object.bib)
    owner_of_picture = Contact.where("dossard = ? AND edition_id = ?", object.bib ,object.edition_id )
    return owner_of_picture
  end

end
