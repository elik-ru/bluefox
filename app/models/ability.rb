class Ability < ActiveRecord::Base
  
  has_many :candidate_abilities
  has_many :candidates, through: :candidate_abilities

  has_many :vacancy_abilities
  has_many :vacancies, through: :vacancy_abilities

  validates_presence_of :name
  validates_uniqueness_of :name

  
end
