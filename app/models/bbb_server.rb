class BbbServer < ApplicationRecord

  belongs_to :user, optional: true
  # has_many :users
  has_and_belongs_to_many :users
  has_and_belongs_to_many :platforms

  validates :name, length: { maximum: 256 }, presence: true
  validates :url, :secret, presence: true
end
