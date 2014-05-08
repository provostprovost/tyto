require 'spec_helper'

describe Tyto::AcceptInvite do
  before do
      Tyto.db.clear_everything
      @course = Tyto.db.create_course(name: "algebra")
      @student = Tyto.db.create_student({username: "Brian",
                                    password: "1234",
                                    email: "parthshahva1@gmail.com",
                                    phone_number: '1234567890'})
      @teacher = Tyto.db.create_teacher({username: "parth",
                                    password: "1234",
                                    email: "pss8te@virginia.edu",
                                    phone_number: '7576507728'})
      @session = Tyto.db.create_session(student_id: @student.id)
  end
  it "returns correct errors" do
    result = subject.run(session_id: @session.id,
                         code:       "13134124124")
    expect(result.error).to eq(:invite_not_found)
  end

   it "rejects an attempt to accept an invite a second time" do
    classroom = Tyto.db.create_classroom( teacher_id: @teacher.id,
                                          course_id:  @course.id,
                                          name: "Period 5" )
    invite = Tyto.db.create_invite(email: "parthshahva1@gmail.com",
                                   teacher_id: @teacher.id,
                                   classroom_id: classroom.id,
                                   code: "123456789",
                                   accepted: true)
    result = subject.run(session_id: @session.id,
                         code:       invite.code)
    expect(result.error).to eq(:invite_already_accepted)

  end

  it "correctly adds students to a classroom" do
    classroom = Tyto.db.create_classroom( teacher_id: @teacher.id,
                                             course_id:  @course.id,
                                             name: "Period 10" )
    invite = Tyto.db.create_invite(email: "parthshahva1@gmail.com",
                                 teacher_id: @teacher.id,
                                 classroom_id: classroom.id,
                                 code: "123456",
                                 accepted: false)
    result = subject.run(session_id: @session.id,
                         code:       invite.code)
    expect(result.classroom_user.student_id).to eq(@student.id)
    expect(result.classroom_user.classroom_id).to eq(classroom.id)
  end

end
