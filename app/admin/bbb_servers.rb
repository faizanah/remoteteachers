ActiveAdmin.register BbbServer do

  permit_params :name, :url, :secret

  controller do
    actions :all, :except => [ :show]
  end

  filter :name

  index :download_links => false do
    column :name
    column :url
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :url
      f.input :secret
    end
    f.actions
  end
end
