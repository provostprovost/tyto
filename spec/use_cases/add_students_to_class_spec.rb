require 'spec_helper'

describe Tyto::AddStudentsToClass do
  before do
    Tyto.db.clear_everything
    @teacher = Tyto.db.create_teacher(username: "Teacher Guy",
                                      password: "98765",
                                      email:    "teacher@email.com",
                                      phone_number: "1234567890" )
    @course = Tyto.db.create_course(name: "algebra")

    @classroom = Tyto.db.create_classroom( teacher_id: @teacher.id,
                                        course_id:  @course.id,
                                        name: "Period 1" )
    @session = Tyto.db.create_session(teacher_id: @teacher.id)
  end

  it "returns correct errors" do
    result = subject.run(session_id:    @session.id,
                         classroom_id:  500000,
                         students:      ['parthshahva@gmail.com', 'pss8te@virginia.edu']
                                  )
    expect(result.error).to eq(:classroom_not_found)
    result = subject.run(session_id:    @session.id,
                         classroom_id:  @classroom.id,
                         students:      []
                                  )
    expect(result.error).to eq(:no_students_added)
  end

  it "correctly adds students to a classroom" do
    result = subject.run(session_id:    @session.id,
                         classroom_id:  @classroom.id,
                         students:      ['parthshahva@gmail.com', 'pss8te@virginia.edu']
                                  )
    expect(result.invites.first.email).to eq('parthshahva@gmail.com')
    expect(result.invites.last.email).to eq('pss8te@virginia.edu')
    expect(result.emails.length).to eq(2)
    expect(result.emails.first.to.first).to eq('parthshahva@gmail.com')
    expect(result.emails.last.to.first).to eq('pss8te@virginia.edu')
  end
end
