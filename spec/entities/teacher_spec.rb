require 'spec_helper'

describe Tyto::Teacher do
  before do
    @teacher = Tyto.db.create_teacher(username: "Brian",
                                email: "brian@fake.com",
                                phone_number: "1234567890",
                                password: "12983712")
  end

  it "creates a teacher" do
    expect(@teacher).to be_a Tyto::Teacher
    expect(@teacher.username).to eq "Brian"
    expect(@teacher.phone_number).to eq "1234567890"
  end

  it "checks password" do
    expect(@teacher.correct_password?("koolpassword")).to be false
    expect(@teacher.correct_password?("12983712")).to be true
  end
end
