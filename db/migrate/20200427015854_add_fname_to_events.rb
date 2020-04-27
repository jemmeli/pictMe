class AddFnameToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :f_name, :string
  end
end
