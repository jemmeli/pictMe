class AddRunnerIdToResults < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :runner_id, :integer
  end
end
