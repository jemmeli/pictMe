class AddLnameToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :l_name, :string
  end
end
