class AddChallengeToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :client_1, :integer
    add_column :events, :client_2, :integer
    add_column :events, :client_3, :integer
    add_column :events, :department, :string
    add_column :events, :challenge_id, :integer
    add_column :events, :global_challenge, :boolean
  end
end
