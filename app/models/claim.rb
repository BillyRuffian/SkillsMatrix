class Claim < ApplicationRecord
  belongs_to :user
  belongs_to :skill

  LEVELS = %i{
    nr
    training
    basic
    good
    expert
  }

  def level=(value)
    level_value = case value.to_sym
    when :training then 1
    when :basic    then 2
    when :good     then 3
    when :expert   then 4
    else 0
    end
    write_attribute :level, level_value
  end

  def level
    case read_attribute :level
    when 1 then :training
    when 2 then :basic
    when 3 then :good
    when 4 then :expert
    else :nr
    end
  end
end
