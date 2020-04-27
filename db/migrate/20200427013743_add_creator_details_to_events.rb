class AddCreatorDetailsToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :f_name, :string
    add_column :events, :l_name, :string
  end
end
