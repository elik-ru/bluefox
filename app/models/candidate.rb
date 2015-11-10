class Candidate < ActiveRecord::Base
  
  has_many :candidate_abilities
  has_many :abilities, through: :candidate_abilities
  
  validates_presence_of :name, :salary, :contact_info
  validates_format_of :name, with: /\A([А-Яа-я]+(\s+|\z)){3,3}\z/, if: "name.present?"
  validates_format_of :contact_info, with: /\A(\+?[0-9]+|[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,})\z/i, if: "contact_info.present?"
  
	scope :active , lambda {where(is_active: true)}
	
end
