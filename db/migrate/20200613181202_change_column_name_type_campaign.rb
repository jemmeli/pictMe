class ChangeColumnNameTypeCampaign < ActiveRecord::Migration[5.0]
  def change
    rename_column :campaigns, :type, :type_campaign
  end
end
