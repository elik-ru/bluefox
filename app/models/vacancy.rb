class Vacancy < ActiveRecord::Base
  has_many :vacancy_abilities
  has_many :abilities, through: :vacancy_abilities
end
