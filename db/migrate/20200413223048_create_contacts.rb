class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :telephone
      t.string :email
      t.string :dossard
      t.string :nom
      t.string :prenom
      t.references :edition, foreign_key: true
    end
  end
end
