class AddPlatformIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :platform_id, :integer
  end
end
