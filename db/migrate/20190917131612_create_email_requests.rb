class CreateEmailRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :email_requests, id: :bigint do |t|
      t.string :email
      t.string :name
      t.timestamps
    end
  end
end
