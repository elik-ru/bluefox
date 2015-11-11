class Vacancy < ActiveRecord::Base
  has_many :vacancy_abilities
  has_many :abilities, through: :vacancy_abilities
  
  validates_presence_of :title, :expires_at, :salary, :contact_info
  validates_presence_of :added_at, on: :update
  
	scope :active , lambda {where("expires_at > ? ", Time.now)}
	
	
  before_create do
    self.added_at ||= self.created_at
  end
  
  def ability_names
    abilities.map{|a| a.name}.join(", ")
  end
  
  def ability_names= array
    array.reject!{|a| a==""}.uniq!
      
    existing=Ability.where(name: array)
    existing_names=existing.map{|a| a.name}

    non_existing=array-existing_names
    new_abilities=non_existing.map{|name| Ability.create(name: name)}

    self.ability_ids=existing.map{|a| a.id} + new_abilities.map{|a| a.id}
  end
  
end
