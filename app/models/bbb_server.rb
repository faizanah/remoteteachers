class BbbServer < ApplicationRecord

  belongs_to :user, optional: true
  # has_many :users
  has_and_belongs_to_many :users
end
