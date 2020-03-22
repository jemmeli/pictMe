class AddDetailsToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :country, :string
    add_column :events, :adress, :string
    add_column :events, :pictme, :boolean, default: false
  end
end
