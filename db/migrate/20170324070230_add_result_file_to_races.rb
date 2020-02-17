class AddResultFileToRaces < ActiveRecord::Migration
  def up
    add_attachment :races, :raw_results
  end

  def down
    remove_attachment :races, :raw_results
  end
end
