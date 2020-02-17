class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races , id: :uuid do |t|
      t.string :name
      t.string :email_sender
      t.string :email_name
      t.date :date
      t.string :hashtag
      t.string :results_url
      t.string :sms_message

      t.timestamps null: false
    end
  end
end
