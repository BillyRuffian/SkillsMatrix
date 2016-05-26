class Skill < ApplicationRecord
  has_many :claims, dependent: :destroy
  has_many :users, through: :claims
end
