ActiveAdmin.register User, as: 'Admins' do
  # menu false
  # scope :moderator
  # scope :admin
  # scope :supervisor

  permit_params :number_of_rooms, :name, :username, :email, :role, :number_of_recordings, :platform_id, :provider, :password

  filter :email
  filter :name
  controller do
    def find_resource
      scoped_collection.where(uid: params[:id]).first!
    end
    def scoped_collection
      User.admin
    end
  end

  index :download_links => false do
    selectable_column
    column :name
    column :email
    # column :number_of_rooms
    # column :number_of_recordings
    column :platform
    column :status do |user|
      user.status.humanize
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :uid
      row :name
      row :username
      row :main_room
      row :email
      row :platform
      row :role
      # row :number_of_rooms
      # row :number_of_recordings
      row :status
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :platform
      # f.input :number_of_rooms
      # f.input :number_of_recordings
      f.input :role, as: :hidden
      f.input :password, as: :hidden, input_html: { value: User.new_token }
      f.input :provider, as: :hidden, input_html: { value: 'greenlight' }
    end
    f.actions
  end

end
