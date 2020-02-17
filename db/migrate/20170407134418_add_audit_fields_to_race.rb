class AddAuditFieldsToRace < ActiveRecord::Migration[5.0]
  def change
    add_column :races, :template, :string
    add_column :results, :uploaded_at, :datetime
    add_column :results, :diploma_generated_at, :datetime
    add_column :results, :email_sent_at, :datetime
    add_column :results, :sms_sent_at, :datetime
  end
end
