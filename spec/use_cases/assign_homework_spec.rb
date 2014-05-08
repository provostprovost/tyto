require 'spec_helper'

describe Tyto::AssignHomework do
  before do
    Tyto.db.clear_everything
    @student = Tyto.db.create_student(username: "Student Guy",
                                      password: "98765",
                                      email:    "student@email.com",
                                      phone_number: "1234567890" )
    @student_two = Tyto.db.create_student(username: "Student",
                                      password: "911",
                                      email:    "student2@email.com",
                                      phone_number: "1234567890" )
    @teacher = Tyto.db.create_teacher(username: "Teacher Guy",
                                      password: "98765",
                                      email:    "teacher@email.com",
                                      phone_number: "1234567890" )
    @course = Tyto.db.create_course(name: "algebra")
    @classroom = Tyto.db.create_classroom( teacher_id: @teacher.id,
                                        course_id:  @course.id,
                                        name: "Period 1" )
    @chapter = Tyto.db.create_chapter(parent_id: @course.id, name: "Cool Chapter")
    @session = Tyto.db.create_session(teacher_id: @teacher.id)
    @question = Tyto.db.create_question( level: 1, question: "2+2",
                                      answer: "4", chapter_id: @chapter.id)

  end

  it "returns correct errors" do
    result = Tyto::AssignHomework.run(:classroom_id => 500000,
                                      :chapter_id => @chapter.id,
                                      :session_id => @session.id,
                                      :assignment_size => 5
                                                          )
    expect(result.error).to eq(:classroom_not_found)
    result = Tyto::AssignHomework.run(:classroom_id => @classroom.id,
                                      :chapter_id => @chapter.id,
                                      :session_id => @session.id,
                                      :assignment_size => 5
                                                          )
    expect(result.error).to eq(:no_students_in_class)

  end

  it "correctly creates assignments for each student" do
    Tyto.db.add_student_to_classroom(classroom_id: @classroom.id,
                                     student_id: @student.id
                                                               )
    Tyto.db.add_student_to_classroom(classroom_id: @classroom.id,
                                     student_id: @student_two.id
                                                               )
    result = Tyto::AssignHomework.run(:classroom_id => @classroom.id,
                                      :chapter_id => @chapter.id,
                                      :session_id => @session.id,
                                      :assignment_size => 5
                                                          )
    expect(result.success?).to eq(true)
    expect(result.assignments.length).to eq(2)
    expect(result.chapter.id).to eq(@chapter.id)
    expect(result.classroom.id).to eq(@classroom.id)
    expect(result.assignments.first.student_id).to eq(@student.id)
    expect(result.assignments.last.student_id).to eq(@student_two.id)
    expect(result.assignments.first.assignment_size).to eq(5)
  end
end
