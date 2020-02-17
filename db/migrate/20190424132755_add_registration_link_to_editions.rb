class AddRegistrationLinkToEditions < ActiveRecord::Migration[5.0]
  def change
    add_column :editions, :registration_link, :string
  end
end
