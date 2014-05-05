require 'spec_helper'

shared_examples_for "a database" do
  let(:db) { described_class.new }

  describe 'Assignments' do
    it "creates an assignment" do
      assignment = db.create_assignment(student_id: 1,
                                        chapter_id: 1,
                                        classroom_id: 1,
                                        teacher_id: 1,
                                        assignment_size: 10)
      expect(assignment).to be_a Tyto::Assignment
      expect(assignment.student_id).to eq 1
      expect(assignment.chapter_id).to eq 1
      expect(assignment.classroom_id).to eq 1
      expect(assignment.id).to_not be nil

    end

    it "gets an assignment" do

    end
  end


   describe 'Chapter' do
    it "creates a chapter" do
      chapter = db.create_chapter(parent_id: 1, name: "Cool Chapter")
      expect(chapter).to be_a Tyto::Chapter
      expect(chapter.name).to eq "Cool Chapter"
    end

    it "gets a chapter" do
      chapter = db.create_chapter(parent_id: 1, name: "Cool Chapter")
      retrieved_chapter = db.get_chapter(chapter.id)
      expect(retrieved_chapter.id).to eq chapter.id
      expect(retrieved_chapter.name).to eq chapter.name
      expect(retrieved_chapter.parent_id).to eq chapter.parent_id
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
