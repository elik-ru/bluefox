class VacancyAbility < ActiveRecord::Base
  
  belongs_to :vacancy
  belongs_to :ability
  
end
