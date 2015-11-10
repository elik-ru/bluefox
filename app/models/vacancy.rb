class Vacancy < ActiveRecord::Base
  has_many :vacancy_abilities
  has_many :abilities, through: :vacancy_abilities
  
  validates_presence_of :title, :expires_at, :salary, :contact_info
  validates_presence_of :added_at, on: :update
  
  before_create do
    self.added_at ||= self.created_at
  end
  
end
