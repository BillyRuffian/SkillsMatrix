class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable

  has_many :claims, -> { includes :skill }, dependent: :destroy
  has_and_belongs_to_many :teams
  has_many :recommended_skills, through: :teams, source: :skills
  has_many :skills_claimed, -> {distinct}, through: :claims, source: :skill
  has_many :leads, class_name: 'Team', foreign_key: :leader_id, inverse_of: :leader
  validates :email,
            presence: true,
            uniqueness: true#,
            #format: {
            #  with: /\A[A-Z0-9._%+-]+@[A-Z0-9.-]*dvla[A-Z0-9.-]*gov\.uk\z/i,
            #  message: 'must be a valid DVLA \'digital\' or GSI address'
            #}

  validates_presence_of :name

  scope :administrators, -> { where( admin: true ) }

  after_create :notify_administrators

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

  def notify_administrators
    Admin::AdminMailer.new_registration_email( self ).deliver_later
  end

end
