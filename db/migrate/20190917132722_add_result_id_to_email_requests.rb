class AddResultIdToEmailRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :email_requests, :result_id, :uuid
  end
end
