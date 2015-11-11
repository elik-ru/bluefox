require 'rails_helper'

RSpec.describe Candidate, :type => :model do

  it "should validate presence of name" do
    candidate=Candidate.create
    expect(candidate.errors[:name].size).to eq(1)
  end

  it "should allow valid name" do
    candidate=Candidate.create(name: "Пупкин Иван Васильевич")
    expect(candidate.errors[:name].size).to eq(0)
  end

  it "should not allow less then 3 words in name" do
    candidate=Candidate.create(name: "Пупкин Иван")
    expect(candidate.errors[:name].size).to eq(1)
    candidate=Candidate.create(name: "Пупкин")
    expect(candidate.errors[:name].size).to eq(1)
  end

  it "should not allow more then 3 words in name" do
    candidate=Candidate.create(name: "Пупкин Иван Пупкин Иван")
    expect(candidate.errors[:name].size).to eq(1)
    candidate=Candidate.create(name: "Пупкин Пупкин Иван Пупкин Иван")
    expect(candidate.errors[:name].size).to eq(1)
  end

  it "should not allow non-russian letters in name" do
    candidate=Candidate.create(name: "Pupkin Ivan Vasilievich")
    expect(candidate.errors[:name].size).to eq(1)
    candidate=Candidate.create(name: "Пупкин Иван 123123")
    expect(candidate.errors[:name].size).to eq(1)
    candidate=Candidate.create(name: "Пупкин Иван22 Васильевич")
    expect(candidate.errors[:name].size).to eq(1)
  end

  it "should allow phone number in contact_info" do
    candidate=Candidate.create(contact_info: "+7(910)123-45-67")
    expect(candidate.errors[:contact_info].size).to eq(0)    
  end
  
  it "should allow email in contact_info" do
    candidate=Candidate.create(contact_info: "test@test.ru")
    expect(candidate.errors[:contact_info].size).to eq(0)    
  end

  it "should allow only phone or email in contact_info" do
    candidate=Candidate.create(contact_info: "на деревню дедушке")
    expect(candidate.errors[:contact_info].size).to eq(1)    
  end



  it "should validate presence of contact_info" do
    candidate=Candidate.create
    expect(candidate.errors[:contact_info].size).to eq(1)
  end

  it "should validate presence of salary" do
    candidate=Candidate.create
    expect(candidate.errors[:salary].size).to eq(1)
  end
  
  it "should be valid on valid params" do
    candidate=Candidate.create(name: "Пупкин Иван Васильевич", is_active: true, salary: 1000000, contact_info: "test@test.ru")
    expect(candidate).to be_valid
  end
	
	it "should select active" do
    Candidate.create(name: "Пупкин Иван Васильевич", is_active: true, salary: 1000000, contact_info: "test@test.ru")
    Candidate.create(name: "Пупкин Иван Васильевич", is_active: false, salary: 1000000, contact_info: "test@test.ru")
		expect(Candidate.active.count).to eq(1)

	end
  
  it "should delete abilities links on destroy" do
    a=Ability.create(name: "Ability")
    c=Candidate.create(name: "Пупкин Иван Васильевич", is_active: true, salary: 1000000, contact_info: "test@test.ru",abilities: [a])
		expect(CandidateAbility.count).to eq(1)
    c.destroy
		expect(CandidateAbility.count).to eq(0)
		expect(Ability.count).to eq(1)
  end


end
