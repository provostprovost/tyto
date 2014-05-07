require 'spec_helper'

describe Tyto::StudentSignUp do
  before { Tyto.db.clear_everything }

  it "returns an error if email address is not valid" do
    result = subject.run( username: "New Guy",
                          password: "as8asd!asd",
                          password_confirmation: "as8asd!asd",
                          email: "bad email@no.com",
                          phone_number: '1234567890' )

    expect(result.error).to eq :email_address_not_valid
  end

  it "returns an error if password does not match confirmation" do
    result = subject.run( username: "New Guy",
                          password: "as8asd!asd",
                          password_confirmation: "as8asd!asdf",
                          email: "fake@email.com",
                          phone_number: '1234567890' )

    expect(result.error).to eq :password_confirmation_does_not_match
  end

  it "returns an error if phone number is not value" do
    result = subject.run( username: "New Guy",
                          password: "as8asd!asd",
                          password_confirmation: "as8asd!asd",
                          email: "fake@email.com",
                          phone_number: '2345a67890' )

    expect(result.error).to eq :phone_number_not_valid
  end

  it "creates a student with valid information" do
    result = subject.run( username: "New Guy",
                          password: "as8asd!asd",
                          password_confirmation: "as8asd!asd",
                          email: "fake1@email.com",
                          phone_number: '1234567890' )

    expect(result.student).to be_a Tyto::Student
    expect(result.student.username).to eq "New Guy"
  end

  describe "non unique" do
    before do
      @coolguy = subject.run( username: "New Guy",
                              password: "as8asd!asd",
                              password_confirmation: "as8asd!asd",
                              email: "fake@email.com",
                              phone_number: '1234567890' )
    end

    it "returns an error if email address is not unique" do
      result = subject.run( username: "New Guy",
                            password: "as8asd!asd",
                            password_confirmation: "as8asd!asd",
                            email: "fake@email.com",
                            phone_number: '1234567890' )

      expect(result.error).to eq :email_address_taken
    end

    it "returns an error if phone number is not unique" do
      result = subject.run( username: "New Guy",
                            password: "as8asd!asd",
                            password_confirmation: "as8asd!asd",
                            email: "fake@gmail.com",
                            phone_number: '1234567890' )

      expect(result.error).to eq :phone_number_taken
    end
  end
end
