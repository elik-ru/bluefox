require 'rails_helper'

RSpec.describe Candidate, :type => :model do

  it "should validate presence of name" do
    candidate=Candidate.create
    expect(candidate.errors[:name].size).to eq(1)
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


end
