class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :claims, -> { includes :skill }, dependent: :destroy
  has_many :skills, through: :claims

  has_and_belongs_to_many :teams
end
