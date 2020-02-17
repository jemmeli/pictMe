class AddExternalLinkToRaces < ActiveRecord::Migration[5.0]
  def change
    add_column :races, :external_link, :string
    add_column :races, :external_link_button, :string
  end
end
