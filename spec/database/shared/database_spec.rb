require 'spec_helper'

shared_examples_for "a database" do
  let(:db) { described_class.new }

  describe 'Assignments' do
    it "creates an assignment" do

    end

    it "gets an assignment" do

    end
  end


   describe 'Chapter' do
    it "creates a chapter" do

    end

    it "gets a chapter" do

    end
  end


  describe 'Classes' do
    it "creates a class" do

    end

    it "gets a class" do

    end
  end


  describe 'Courses' do
    it "creates a course" do

    end

    it "gets a course" do

    end
  end


  describe 'Questions' do
    it "creates a question" do

    end

    it "gets a question" do

    end
  end


  describe 'Responses' do
    it "creates a response" do

    end

    it "gets a response" do

    end
  end


  describe 'Sessions' do
    it "creates a session" do

    end

    it "gets a session" do

    end
  end


  describe 'Students' do
    it "creates a student" do

    end

    it "gets a student" do

    end
  end

  describe 'Teachers' do
    it "creates a teacher" do
      teacher = db.create_teacher({username: "parth", password: "1234", email: "pss8te@virginia.edu", phone_number: '7576507728'})
      expect(teacher.username).to eq("parth")
      expect(teacher.password).to eq("1234")
    end

    it "gets a teacher" do

    end
    it "edits a teacher" do

    end
    it "deletes a teacher" do

    end
  end
end
