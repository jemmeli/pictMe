class CreateRunners < ActiveRecord::Migration[5.0]
  def change
    create_table :runners do |t|
      t.string :id_key
      t.string :first_name
      t.string :last_name
      t.datetime :dob
      t.string :department
      t.string :sex

      t.timestamps
    end

    add_index :runners, :id_key, unique: true
  end
end
