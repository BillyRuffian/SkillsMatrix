class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable

  has_many :claims, -> { includes :skill }, dependent: :destroy
  has_and_belongs_to_many :teams
  has_many :recommended_skills, through: :teams, source: :skills
  has_many :skills_claimed, -> {uniq}, through: :claims, source: :skill

  def first_sign_in?
    current_sign_in_at == last_sign_in_at
  end

  def member_of? team
    teams.include? team
  end
end
