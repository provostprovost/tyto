require 'spec_helper'

shared_examples_for "a database" do
  let(:db) { described_class.new }
  before { db.clear_everything }

  describe 'Assignments' do
    before do
      @assignment = db.create_assignment( student_id: 1,
                                          chapter_id: 1,
                                          classroom_id: 1,
                                          teacher_id: 1,
                                          assignment_size: 10)
    end

    it "creates an assignment" do
      expect(@assignment).to be_a Tyto::Assignment
      expect(@assignment.student_id).to eq 1
      expect(@assignment.chapter_id).to eq 1
      expect(@assignment.classroom_id).to eq 1
      expect(@assignment.id).to_not be nil
    end

    it "gets an assignment" do
      retrieved_assignment = db.get_assignment(@assignment.id)
      expect(retrieved_assignment.id).to eq(@assignment.id)
      expect(retrieved_assignment.student_id).to eq(@assignment.student_id)
      expect(retrieved_assignment.classroom_id).to eq(@assignment.classroom_id)
      expect(retrieved_assignment.teacher_id).to eq(@assignment.teacher_id)
      expect(retrieved_assignment.assignment_size).to eq(@assignment.assignment_size)
    end

    it "edits an assignment" do
      db.edit_assignment( id: @assignment.id,
                          assignment_size: 15,
                          classroom_id: 4,
                          teacher_id: 9)
      edited_assignment = db.get_assignment(@assignment.id)
      expect(edited_assignment.id).to eq @assignment.id
      expect(edited_assignment.assignment_size).to eq 15
    end
  end


   describe 'Chapter' do
    before do
      @chapter = db.create_chapter(parent_id: 1, name: "Cool Chapter")
    end

    it "creates a chapter" do
      expect(@chapter).to be_a Tyto::Chapter
      expect(@chapter.name).to eq "Cool Chapter"
    end

    it "gets a chapter" do
      retrieved_chapter = db.get_chapter(@chapter.id)
      expect(retrieved_chapter.id).to eq @chapter.id
      expect(retrieved_chapter.name).to eq @chapter.name
      expect(retrieved_chapter.parent_id).to eq @chapter.parent_id
    end

    it "edits a chapter" do
      db.edit_chapter(  id: @chapter.id,
                        name: "Edited Chapter" )
      edited_chapter = db.get_chapter(@chapter.id)
      expect(edited_chapter.id).to eq @chapter.id
      expect(edited_chapter.name).to eq "Edited Chapter"
    end
  end


  describe 'Classroom' do
    before do
      @classroom = db.create_classroom( teacher_id: 55,
                                        course_id:  66 )
    end

    it "creates a classroom" do
      expect(@classroom).to be_a Tyto::Classroom
      expect(@classroom.teacher_id).to eq 55
      expect(@classroom.course_id).to eq 66
    end

    it "gets a classroom" do
      retrieved_classroom = db.get_classroom(@classroom.id)
      expect(retrieved_classroom.id).to eq @classroom.id
      expect(retrieved_classroom.teacher_id).to eq @classroom.teacher_id
      expect(retrieved_classroom.course_id).to eq @classroom.course_id
    end

    it "can add a student to a classroom" do
      pair = db.add_student_to_classroom(classroom_id: @classroom.id, student_id: 55)
      expect(pair.student_id).to eq 55
      expect(pair.classroom_id).to eq @classroom.id
    end

    it "can get all students from a classroom" do
      student1 = db.create_student({username: "parth", password: "1234", email: "pss8te@virginia.edu", phone_number: '7576507728'})
      student2 = db.create_student({username: "brian", password: "1234", email: "asdfasd@virginia.edu", phone_number: '0987654321'})
      student3 = db.create_student({username: "gilbert", password: "1234", email: "psffffffs8te@virginia.edu", phone_number: '1234567890'})


    end
  end


  describe 'Courses' do
    it "creates a course" do

    end

    it "gets a course" do

    end
  end


  describe 'Questions' do
    before do
      @question = db.create_question(level: 5, question: "2+2", answer: "4", chapter_id: 5)
    end
    it "creates a question" do
      expect(@question.level).to eq(5)
      expect(@question.question).to eq("2+2")
      expect(@question.answer).to eq("4")
      expect(@question.chapter_id).to eq(5)
    end

    it "gets a question" do
      question = db.get_question(@question.id)
      expect(question.level).to eq(5)
      expect(question.question).to eq("2+2")
      expect(question.answer).to eq("4")
      expect(question.chapter_id).to eq(5)
    end

    it "edits a question" do
      question = db.edit_question(id: @question.id, chapter_id: 10)
      expect(question.chapter_id).to eq(10)
      expect(question.level).to eq(5)
    end
  end


  describe 'Responses' do
    before do
      @response = db.create_response(correct: true, question_id: 1, student_id: 5, assignment_id: 10)
    end
    it "creates a response" do
      expect(@response.correct).to eq(true)
      expect(@response.question_id).to eq(1)
      expect(@response.student_id).to eq(5)
      expect(@response.assignment_id).to eq(10)
    end

    it "gets a response" do
      response = db.get_response(@response.id)
      expect(response.correct).to eq(true)
      expect(response.question_id).to eq(1)
      expect(response.student_id).to eq(5)
      expect(response.assignment_id).to eq(10)
    end
  end


  describe 'Sessions' do
    before do
      @student_session = db.create_student_session(student_id: 5)
      @teacher_session = db.create_teacher_session(teacher_id: 6)
    end
    it "creates a student session" do
      expect(@student_session.student_id).to eq(5)
    end

    it "gets a student session" do
      student_session = db.get_student_session(@student_session.id)
      expect(@student_session.student_id).to eq(5)
    end
    it "creates a teacher session" do
      expect(@teacher_session.teacher_id).to eq(6)
    end
    it "gets a teacher session" do
      teacher_session = db.get_teacher_session(@teacher_session.id)
      expect(@teacher_session.teacher_id).to eq(6)
    end
  end


  describe 'Students' do
    before do
      @student = db.create_student({username: "parth", password: "1234", email: "pss8te@virginia.edu", phone_number: '7576507728'})
    end
    it "creates a student" do
      expect(@student.username).to eq("parth")
      expect(@student.password).to eq("1234")
    end

    it "gets a student" do
      fetched_student = db.get_teacher(@student.id)
      expect(fetched_student.phone_number).to eq("7576507728")
    end

    it "edits a student" do
      student = db.edit_student(:id => @student.id, password: "1111")
      expect(student.username).to eq("parth")
      expect(student.password).to eq("1111")
    end
  end

  describe 'Teachers' do
    before do
      @teacher = db.create_teacher({username: "parth", password: "1234", email: "pss8te@virginia.edu", phone_number: '7576507728'})
    end
    it "creates a teacher" do
      expect(@teacher.username).to eq("parth")
      expect(@teacher.password).to eq("1234")
    end

    it "gets a teacher" do
      fetched_teacher = db.get_teacher(@teacher.id)
      expect(fetched_teacher.phone_number).to eq("7576507728")
    end
    it "edits a teacher" do
      teacher = db.edit_teacher(:id => @teacher.id, password: "1111")
      expect(teacher.username).to eq("parth")
      expect(teacher.password).to eq("1111")
    end
  end
end
