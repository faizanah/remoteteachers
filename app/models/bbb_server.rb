class BbbServer < ApplicationRecord

  belongs_to :user, optional: true
  has_many :users
end
