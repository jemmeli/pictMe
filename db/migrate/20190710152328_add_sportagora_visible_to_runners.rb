class AddSportagoraVisibleToRunners < ActiveRecord::Migration[5.0]
  def change
    add_column :runners, :sportagora_visible, :boolean, default: true
  end
end
