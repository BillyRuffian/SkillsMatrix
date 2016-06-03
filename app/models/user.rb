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
  has_many :leads, class_name: 'Team', foreign_key: :leader_id, inverse_of: :leader

  validates_presence_of :name

  def first_sign_in?
    current_sign_in_at == last_sign_in_at
  end

  def member_of? team
    teams.include? team
  end

  def team_leader?
    ! leads.empty?
  end

  def team_leader_of? team
    leads.includes? team
  end
end
