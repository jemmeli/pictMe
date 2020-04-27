class AddCreatorDetailsToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :fname, :string
    add_column :events, :lname, :string
  end
end
