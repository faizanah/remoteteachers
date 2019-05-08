class AddBbbServerIdColumnToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :bbb_server_id, :integer, index: true, foreign_key: true
  end
end
