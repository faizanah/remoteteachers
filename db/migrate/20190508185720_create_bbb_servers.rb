class CreateBbbServers < ActiveRecord::Migration[5.0]
  def change
    create_table :bbb_servers do |t|
      t.string :name
      t.string :url
      t.string :secret
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
