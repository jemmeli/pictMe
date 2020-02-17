class AddRealFlagToRunners < ActiveRecord::Migration[5.0]
  def change
    add_column :runners, :real, :boolean, default: true
  end
end
