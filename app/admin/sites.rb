ActiveAdmin.register Site do
  menu priority: 7

  controller do
    actions :all, :except => [ :destroy, :new, :create]
  end
  permit_params :name, :domain_url, :privacy_and_policy_url, :terms_and_condition_url

  config.filters = false

  index :download_links => false do
    column :name
    column :domain_url
    actions
  end

  show do
    attributes_table do
      row :name
      row :domain_url
      row :privacy_and_policy_url
      row :terms_and_condition_url
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :domain_url
      f.input :privacy_and_policy_url
      f.input :terms_and_condition_url
    end
    f.actions
  end

end
