class Ability < ActiveRecord::Base
  
  has_many :candidate_abilities
  has_many :candidates, through: :candidate_abilities

  has_many :vacancy_abilities
  has_many :vacancies, through: :vacancy_abilities

  
end
