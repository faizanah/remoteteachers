class CreateJoinTableBbbServerUser < ActiveRecord::Migration[5.0]
  def change
    create_table :bbb_servers_users, :id => false do |t|
      t.integer :user_id
      t.integer :bbb_server_id
    end
  end
end
