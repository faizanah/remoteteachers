ActiveAdmin.register Platform do

  menu priority: 2

  permit_params :name, :user_id, bbb_server_ids: []

  filter :name

  index do
    column :name
    column :admin
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :bbb_server_ids, as: :check_boxes, collection: BbbServer.all
      f.input :user_id, :label => 'Admin', :as => :select, :collection => User.admin.accepted.map{|u| ["#{u.name} <#{u.email}>", u.id]}

    end
    f.actions
  end

end
