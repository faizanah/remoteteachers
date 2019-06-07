class CreatePlatforms < ActiveRecord::Migration[5.0]
  def change
    create_table :platforms do |t|
      t.belongs_to :user, index: true
      t.string :name, index: true
      t.integer :users_count, default: 0
      t.timestamps
    end
    create_table :bbb_servers_platforms, :id => false do |t|
      t.integer :platform_id
      t.integer :bbb_server_id
    end
  end
end
