class CreateSites < ActiveRecord::Migration[5.0]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :domain_url
      t.string :privacy_and_policy_url
      t.string :terms_and_condition_url
      t.timestamps
    end
  end
end
