require 'spec_helper'

describe Tyto::AcceptInvite do
  before do
      @course = db.create_course(name: "algebra")
      @classroom = db.create_classroom( teacher_id: 55,
                                        course_id:  66,
                                        name: "Period 1" )
      @student = db.create_student({username: "Brian",
                                    password: "1234",
                                    email: "fake@email.com",
                                    phone_number: '1234567890'})
      @teacher = db.create_teacher({username: "parth",
                                    password: "1234",
                                    email: "pss8te@virginia.edu",
                                    phone_number: '7576507728'})
      @invite = db.create_invite(email: "parthshahva@gmail.com",
                                 teacher_id: @teacher.id,
                                 classroom_id: @classroom.id,
                                 code: "1234",
                                 accepted: false)
  end
  it "returns correct errors" do

  end

  it "correctly adds students to a classroom" do

  end
end
