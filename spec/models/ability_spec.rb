require 'rails_helper'

RSpec.describe Ability, :type => :model do
  it "should validate presence of name" do
    ability=Ability.create
    expect(ability).to be_invalid
    
    ability=Ability.create(name: "")
    expect(ability).to be_invalid
    
    ability=Ability.create(name: "Some Ability")
    expect(ability).to be_valid
  end
  
  it "should validate uniqueness of name" do

    ability=Ability.create(name: "Some Ability")
    expect(ability).to be_valid
    ability=Ability.create(name: "Some Ability")
    expect(ability).to be_invalid

  end
  
  
end
