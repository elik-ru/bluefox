class Candidate < ActiveRecord::Base
  
  has_many :candidate_abilities
  has_many :abilities, through: :candidate_abilities
  
  validates_presence_of :name, :salary, :contact_info
  
end
