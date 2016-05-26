class Skill < ApplicationRecord
  has_many :claims, dependent: :destroy
  has_many :users, through: :claims

  has_and_belongs_to_many :teams
end
