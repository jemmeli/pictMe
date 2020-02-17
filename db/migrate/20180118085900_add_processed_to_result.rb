class AddProcessedToResult < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :processed, :boolean, default: false
  end
end
