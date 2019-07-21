ActiveAdmin.register Platform do

  menu priority: 2

  permit_params :name, :user_id, bbb_server_ids: []

  filter :name

  index :download_links => false do
    column :name
    column :admin
    column :users_count
    column 'Servers Count' do |platform|
      platform.bbb_servers.count
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :admin
      row :users_count
      row :created_at
    end

    panel "List of BBB Servers" do
      table_for platform.bbb_servers do
        column :name
        column :url
        column :created_at
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      # f.input :bbb_server_ids, as: :check_boxes, collection: BbbServer.all
      f.input :bbb_server_ids, as: :select, multiple: true, collection: BbbServer.all.map {|u| [u.name, u.id]}

      f.input :user_id, :label => 'Admin', :as => :select, :collection => User.admin.accepted.map{|u| ["#{u.name} <#{u.email}>", u.id]}

    end
    f.actions
  end

end
