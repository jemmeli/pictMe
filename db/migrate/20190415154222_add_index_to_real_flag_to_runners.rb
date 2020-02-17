class AddIndexToRealFlagToRunners < ActiveRecord::Migration[5.0]
  def change
    add_index :runners, :real
  end
end
