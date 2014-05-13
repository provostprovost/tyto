require 'spec_helper'

describe Tyto::UpdateStudent do
  before do
    Tyto.db.clear_everything
    @result = Tyto::StudentSignUp.run( username: "New Guy",
                          password: "as8asd!asd",
                          password_confirmation: "as8asd!asd",
                          email: "fake@email.com",
                          phone_number: '1234567890' )
    @session_id = Tyto::SignIn.run( email: "fake@email.com", password: "as8asd!asd").session_id
  end

  it "returns an error if not logged in" do
    result = subject.run( session_id: 9999,
                          username: "Cooler Name",
                          password: "as8asd!asd",
                          password_confirmation: "as8asd!asd",
                          email: "cooleremail@email.com",
                          phone_number: '5552220000' )
    expect(result.error).to eq :session_not_found
  end

  it "returns an error if email address is not valid" do
    result = subject.run( session_id: @session_id,
                          username: "New Guy",
                          password: "as8asd!asd",
                          password_confirmation: "as8asd!asd",
                          email: "bad email@no.com",
                          phone_number: '1234567890' )

    expect(result.error).to eq :email_address_not_valid
  end

  it "returns an error if password does not match confirmation" do
    result = subject.run( session_id: @session_id,
                          username: "New Guy",
                          password: "as8asd!asd",
                          password_confirmation: "as8asd!asdf",
                          email: "fake@email.com",
                          phone_number: '1234567890' )

    expect(result.error).to eq :password_confirmation_does_not_match
  end

  it "returns an error if phone number is not value" do
    result = subject.run( session_id: @session_id,
                          username: "New Guy",
                          password: "as8asd!asd",
                          password_confirmation: "as8asd!asd",
                          email: "fake@email.com",
                          phone_number: '2345a67890' )

    expect(result.error).to eq :phone_number_not_valid
  end

  describe "non unique" do
    before do
      @coolguy = Tyto::StudentSignUp.run( username: "Cool Guy",
                              password: "as8asd!asd",
                              password_confirmation: "as8asd!asd",
                              email: "coolguy@email.com",
                              phone_number: '0987654321' )
    end

    it "returns an error if email address is not unique" do
      result = subject.run( session_id: @session_id,
                            username: "New Guy",
                            password: "as8asd!asd",
                            password_confirmation: "as8asd!asd",
                            email: "coolguy@email.com",
                            phone_number: '1234567890' )

      expect(result.error).to eq :email_address_taken
    end

    it "returns an error if phone number is not unique" do
      result = subject.run( session_id: @session_id,
                            username: "New Guy",
                            password: "as8asd!asd",
                            password_confirmation: "as8asd!asd",
                            email: "fake@email.com",
                            phone_number: '0987654321' )

      expect(result.error).to eq :phone_number_taken
    end
  end

  it "successfully edits student's attributes" do
    result = subject.run( session_id: @session_id,
                          username: "Cooler Name",
                          password: "as8asd!asd",
                          password_confirmation: "as8asd!asd",
                          email: "cooleremail@email.com",
                          phone_number: '5552220000' )
    expect(result.success?).to eq true
  end
end
