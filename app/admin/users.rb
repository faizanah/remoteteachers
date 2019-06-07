ActiveAdmin.register User do
  menu false
  controller do
    actions :all, :except => [ :new, :destroy, :edit, :index]
  end

  show do
    attributes_table do
      row :name
      row :username
      row :email
      row :role
      row :number_of_rooms
      row :number_of_recordings
      row :created_at
    end
  end
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
