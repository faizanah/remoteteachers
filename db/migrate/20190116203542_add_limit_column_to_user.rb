class AddLimitColumnToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :number_of_rooms, :integer, default: 0
    add_column :users, :number_of_recordings, :integer, default: 0
  end
end
