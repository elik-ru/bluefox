class Candidate < ActiveRecord::Base
  
  has_many :candidate_abilities
  has_many :abilities, through: :candidate_abilities
  
  validates_presence_of :name, :salary, :contact_info
  validates_format_of :name, with: /\A([А-Яа-я]+(\s+|\z)){3,3}\z/, if: "name.present?" , message: "Введите ФИО (три слова) по-русски"
  validates_format_of :contact_info, with: /\A(\+\d\(\d\d\d\)\d\d\d-\d\d-\d\d|[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,})\z/i, if: "contact_info.present?" , message: "Введите номер телефона (пример: +7(910)123-45-67) или E-mail"
  
	scope :active , lambda {where(is_active: true)}
  
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
