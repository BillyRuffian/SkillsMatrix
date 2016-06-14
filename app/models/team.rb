class Team < ApplicationRecord
  has_and_belongs_to_many :skills
  has_and_belongs_to_many :users

  belongs_to :leader, class_name: 'User', inverse_of: :leads

  validates_presence_of :name
  validates_uniqueness_of :name
end
