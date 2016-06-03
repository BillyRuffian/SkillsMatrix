class Skill < ApplicationRecord
  has_many :claims, dependent: :destroy
  has_many :users, through: :claims

  has_and_belongs_to_many :teams

  validates_uniqueness_of :name

  scope :for_user, -> user { joins(:claims).where( 'claims.user_id = ?', user.id) }
  scope :acquired, -> { joins(:claims).where( 'claims.level > 1' ) }
  scope :training, -> { joins(:claims).where( 'claims.level = 1' ) }
  scope :new_since, -> time { where( 'created_at > ? ', time ) }

  # for autocomplete
  scope :unique_types, -> { group( :context ) }

  def used_by? team
    return teams.include? team
  end
end
