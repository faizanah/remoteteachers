class AddColumnToUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :bbb_servers, :user_id, :integer
    add_column :bbb_servers, :user_id, :integer
  end
end
