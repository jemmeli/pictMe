class CreateEditions < ActiveRecord::Migration[5.0]
  def change
    create_table :editions do |t|
      t.date :date
      t.string :description
      t.integer :event_id

      t.string   :email_sender
      t.string   :email_name
      t.string   :hashtag
      t.string   :results_url
      t.string   :sms_message
      t.string   :template
      t.datetime :widget_generated_at
      t.datetime :photos_widget_generated_at
      t.string   :external_link
      t.string   :external_link_button

      t.timestamps
    end
  end
end
