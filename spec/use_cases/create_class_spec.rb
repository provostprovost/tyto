require 'spec_helper'

describe Tyto::CreateClassroom do
  before do
    @teacher = Tyto.db.create_teacher({username: "parth",
                                  password: "1234",
                                  email: "pss8te@virginia.edu",
                                  phone_number: '7576507728'})
    @course = Tyto.db.create_course(name: "algebra")
  end

  it "creates a classroom with correct inputs" do
    result = subject.run(:classroom_name => "Period 1", :course_name => 'algebra', :teacher_id => @teacher.id)
    expect(result.classroom.teacher_id).to eq(@teacher.id)
    expect(result.classroom.course_id).to eq(@course.id)
    expect(result.classroom.name).to eq("Period 1")
  end
end
