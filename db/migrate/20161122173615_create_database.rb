class CreateDatabase < ActiveRecord::Migration
  def change
    #ajout d'extensions
    execute "CREATE EXTENSION hstore;"
    execute "CREATE EXTENSION unaccent;"
    enable_extension 'uuid-ossp'


    create_table :users, id: false, force: true do |t|
      t.uuid :id, :default => "uuid_generate_v4()"
      t.string :token
      t.string :first_name
      t.string :last_name
      t.string :language
      t.string :email
      t.string :phone
      t.timestamps
    end

    add_index(:users, :token)
    execute "ALTER TABLE users ADD PRIMARY KEY (id);"
  end
end
