require 'spec_helper'

describe Tyto::AnswerQuestion do
  before { Tyto.db.clear_everything }

  before do
    @chapter = Tyto.db.create_chapter( parent_id: 1, name: "Cool Chapter" )
    @student = Tyto.db.create_student(  username: "Kool Guy",
                                        password: "supercool500",
                                        email: "koolguy@email.com",
                                        phone_number: '1234567890' )
    @question = Tyto.db.create_question(  level: 2,
                                          question: "What's up kool guy?",
                                          answer: "NM here",
                                          chapter_id: @chapter.id)
    @assignment = Tyto.db.create_assignment(  student_id: @student.id,
                                              chapter_id: @chapter.id,
                                              classroom_id: 1,
                                              teacher_id: 1,
                                              assignment_size: 10)
    @session = Tyto.db.create_session(student_id: @student.id)
  end

  it "returns an error if session is not valid" do
    result = subject.run( question_id: @question.id,
                          answer: "NM here",
                          assignment_id: @assignment.id,
                          session_id: 999999,
                          difficult: false )

    expect(result.error).to eq :session_not_found
  end

  it "returns an error if assignment is not found" do
    result = subject.run( question_id: @question.id,
                          answer: "NM here",
                          assignment_id: 99999,
                          session_id: @session.id,
                          difficult: false )

    expect(result.error).to eq :assignment_not_found
  end

  it "returns an error if not student's assignment" do
    other_assignment = Tyto.db.create_assignment( student_id: 999999,
                                                  chapter_id: @chapter.id,
                                                  classroom_id: 1,
                                                  teacher_id: 1,
                                                  assignment_size: 10)
    result = subject.run( question_id: @question.id,
                          answer: "NM here",
                          assignment_id: other_assignment.id,
                          session_id: @session.id,
                          difficult: false )
    expect(result.error).to eq :assignment_not_valid
  end

  it "returns an error if question does not exist" do
    result = subject.run( question_id: 999999,
                          answer: "NM here",
                          assignment_id: @assignment.id,
                          session_id: @session.id,
                          difficult: false )
    expect(result.error).to eq :question_not_found
  end

  it "check answer method checks answer!" do
    correct = subject.check_answer(@question.id, "NM here")
    expect(correct).to eq true

    incorrect = subject.check_answer(@question.id, "just chilling brotherman")
    expect(incorrect).to eq false
  end

  describe "with correct inputs" do
    before do
      @result = subject.run( question_id: @question.id,
                            answer: "NM here",
                            assignment_id: @assignment.id,
                            session_id: @session.id,
                            difficult: false )
    end

    it "creates a new response" do
      expect(@result.response).to be_a(Tyto::Response)
      expect(@result.response.correct).to eq true
      expect(@result.response.proficiency).to be_a Integer
      expect(@result.response.question_id).to eq @question.id
      expect(@result.response.student_id).to eq @student.id
      expect(@result.response.assignment_id).to eq @assignment.id
      expect(@result.response.difficult).to eq false
      expect(@result.response.chapter_id).to eq @chapter.id
    end

    it "returns the next question" do
      10.times do
        Tyto.db.create_question(  level: 1,
                                  question: "What's up kool guy?",
                                  answer: "NM here",
                                  chapter_id: @chapter.id)
      end
      result = subject.run( question_id: @question.id,
                            answer: "NM here",
                            assignment_id: @assignment.id,
                            session_id: @session.id,
                            difficult: false )

      expect(result.question).to be_a(Tyto::Question)
      expect(result.question.chapter_id).to eq @chapter.id
    end

    it "returns complete=false if assignment is not finished" do
      expect(@result.complete).to eq false
    end

    it "returns complete=true if assignment is finished" do
      assignment1 = Tyto.db.create_assignment(  student_id: @student.id,
                                                chapter_id: @chapter.id,
                                                classroom_id: 1,
                                                teacher_id: 1,
                                                assignment_size: 1)
      @result = subject.run( question_id: @question.id,
                            answer: "NM here",
                            assignment_id: assignment1.id,
                            session_id: @session.id,
                            difficult: false )
      expect(@result.complete).to eq true
    end

    it "keeps track of number of questions completed" do
      expect(@result.number_answered).to eq 1

      result1 = subject.run( question_id: @question.id,
                            answer: "chilling bro",
                            assignment_id: @assignment.id,
                            session_id: @session.id,
                            difficult: false )
      expect(result1.number_answered).to eq 2
    end
  end
end
