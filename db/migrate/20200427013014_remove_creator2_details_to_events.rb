class RemoveCreator2DetailsToEvents < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :f_name, :string
    remove_column :events, :l_name, :string
  end
end
