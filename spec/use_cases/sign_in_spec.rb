require 'spec_helper'

describe Tyto::SignIn do
  before do
    @student = Tyto.db.create_student(username: "Student Guy",
                                      password: "98765",
                                      email:    "student@email.com",
                                      phone_number: "1234567890" )
    @teacher = Tyto.db.create_teacher(username: "Teacher Guy",
                                      password: "98765",
                                      email:    "teacher@email.com",
                                      phone_number: "1234567890" )
  end

  it "returns an error if student user is not found" do
    result = subject.run( email: "wrongguy@email.com",
                          password: "safepassword",
                          teacher: false)

    expect(result.success?).to eq false
    expect(result.error).to eq :user_not_found
  end

    it "returns an error if teacher user is not found" do
    result = subject.run( email: "wrongguy@email.com",
                          password: "safepassword",
                          teacher: true)

    expect(result.success?).to eq false
    expect(result.error).to eq :user_not_found
  end

  it "returns an error if password does not match" do
    result = subject.run( email: @teacher.email,
                          password: "safepassword",
                          teacher: true)

    expect(result.success?).to eq false
    expect(result.error).to eq :incorrect_password

    result = subject.run( email: @student.email,
                          password: "safepassword",
                          teacher: false)

    expect(result.success?).to eq false
    expect(result.error).to eq :incorrect_password
  end

  it "returns a session if sign in is successful" do
    result = subject.run( email: @teacher.email,
                          password: "98765",
                          teacher: true)

    expect(result.success?).to eq true
    expect(result.session_id).to be_a Integer
    expect(result.user.username).to eq @teacher.username

    result = subject.run( email: @student.email,
                          password: "98765",
                          teacher: false)

    expect(result.success?).to eq true
    expect(result.session_id).to be_a Integer
    expect(result.user.username).to eq @student.username
  end
end
