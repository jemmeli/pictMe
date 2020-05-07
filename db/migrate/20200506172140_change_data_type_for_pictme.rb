class ChangeDataTypeForPictme < ActiveRecord::Migration[5.0]
  #https://medium.com/sudo-by-icalia-labs/cast-rails-migrations-data-types-c4f6c8ae73e3
  def self.up 
    change_column :events, :pictme, :string
   end

  def self.down 
    change_column :events, :pictme, 'boolean USING CAST(pictme AS boolean)'
   end 
end
