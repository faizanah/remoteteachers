class Platform < ApplicationRecord
  has_many :users
  has_and_belongs_to_many :bbb_servers
  belongs_to :admin, class_name: 'User', foreign_key: 'user_id', optional: true

  after_commit :set_platform

  private

  def set_platform
    self.admin.update({platform_id: id }) if admin.present?
  end

end
