class AddAttachmentDiplomaToResult < ActiveRecord::Migration[5.0]
  def change
    add_attachment :results, :diploma
    add_column :results, :purchased_at, :datetime
    add_column :results, :stripe_charge_id, :string
  end
end
