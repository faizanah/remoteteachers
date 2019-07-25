ActiveAdmin.register User, as: 'Admins' do
  # menu false
  # scope :moderator
  # scope :admin
  # scope :supervisor
  filter :email
  filter :name
  controller do
    # actions :all, :except => [ :new, :destroy, :edit, :index]
    def find_resource
      scoped_collection.where(uid: params[:id]).first!
    end
    def scoped_collection
      User.admin
    end
  end

  index do
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

  # t.integer  "room_id"
  # t.string   "provider"
  # t.string   "uid"
  # t.string   "name"
  # t.string   "username"
  # t.string   "email"
  # t.string   "social_uid"
  # t.string   "image"
  # t.integer  "role",                 default: 0
  # t.integer  "invited_by_id"
  # t.string   "invitation_token"
  # t.string   "password_digest"
  # t.boolean  "accepted_terms",       default: false
  # t.datetime "created_at",                               null: false
  # t.datetime "updated_at",                               null: false
  # t.boolean  "email_verified",       default: false
  # t.string   "language",             default: "default"
  # t.string   "reset_digest"
  # t.datetime "reset_sent_at"
  # t.integer  "status",               default: 0
  # t.integer  "number_of_rooms",      default: 0
  # t.integer  "number_of_recordings", default: 0
  # t.integer  "bbb_server_id"
  # t.integer  "platform_id"

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

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :platform
      f.input :number_of_rooms
      f.input :number_of_recordings
      f.input :role, as: :hidden
      f.input :password, as: :hidden, input_html: { value: User.new_token }
      f.input :provider, as: :hidden, input_html: { value: 'greenlight' }
      # f.input :bbb_server_ids, as: :check_boxes, collection: BbbServer.all
      # f.input :bbb_server_ids, as: :select, multiple: true, collection: BbbServer.all.map {|u| [u.name, u.id]}

      # f.input :user_id, :label => 'Admin', :as => :select, :collection => User.admin.accepted.map{|u| ["#{u.name} <#{u.email}>", u.id]}

    end
    f.actions
  end

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :number_of_rooms, :name, :username, :email, :role, :number_of_recordings, :platform_id, :provider, :password

end
