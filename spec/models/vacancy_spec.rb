require 'rails_helper'

RSpec.describe Vacancy, :type => :model do

  it "should validate presence of title" do
    vacancy=Vacancy.create
    expect(vacancy.errors[:title].size).to eq(1)
  end

  it "should validate presence of expiration date" do
    vacancy=Vacancy.create
    expect(vacancy.errors[:expires_at].size).to eq(1)
  end

  it "should validate presence of creation date on update" do
    vacancy=Vacancy.create(title: "Тестовая вакансия", added_at: Time.now, expires_at: 1.month.from_now, salary: 1000000, contact_info: "ООО Рога и копыта")
    vacancy.update(added_at: nil)
    expect(vacancy.errors[:added_at].size).to eq(1)
  end

  it "should validate presence of salary" do
    vacancy=Vacancy.create
    expect(vacancy.errors[:salary].size).to eq(1)
  end
  
  it "should validate presence of contact_info" do
    vacancy=Vacancy.create
    expect(vacancy.errors[:contact_info].size).to eq(1)
  end
  
  it "should be valid on valid params" do
    vacancy=Vacancy.create(title: "Тестовая вакансия", added_at: Time.now, expires_at: 1.month.from_now, salary: 1000000, contact_info: "ООО Рога и копыта")
    expect(vacancy).to be_valid
  end

  it "should defaults creation date" do
    vacancy=Vacancy.create(title: "Тестовая вакансия", expires_at: 1.month.from_now, salary: 1000000, contact_info: "ООО Рога и копыта")
    expect(vacancy).to be_valid
    expect(vacancy.added_at).to eq(vacancy.created_at)
  end


end
