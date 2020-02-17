class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :place
      t.string :website
      t.string :facebook
      t.string :twitter
      t.string :instagram
      t.string :contact
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
