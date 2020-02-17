class AddDiplomaInfosToEdition < ActiveRecord::Migration[5.0]
  def change
    add_column :editions, :sendable_at_home, :boolean, default: false
    add_monetize :editions, :sendable_at_home_price, amount: { null: true, default: nil }, currency: { present: false }
    add_column :editions, :download_chargeable, :boolean, default: false
    add_monetize :editions, :download_chargeable_price, amount: { null: true, default: nil }, currency: { present: false }
  end
end
