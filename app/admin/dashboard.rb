ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }


  content title: "Dashboard" do
    panel 'Welcome Admin' do
      @user_registered_by_month = User.group_by_month(:created_at, format: "%b %Y").count
      render partial: 'user_registration_chart', locals: {user_registered_by_month: @user_registered_by_month}
    end
  end # content
end
