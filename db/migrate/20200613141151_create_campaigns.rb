class CreateCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
      t.string :name
      t.string :type
      t.string :sender_email
      t.string :subject
      t.string :msg
      t.references :edition, foreign_key: true
    end
  end
end
