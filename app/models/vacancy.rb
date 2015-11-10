class Vacancy < ActiveRecord::Base
  has_many :vacancy_abilities
  has_many :abilities, through: :vacancy_abilities
  
  validates_presence_of :title, :added_at, :expires_at, :salary, :contact_info
  
end
