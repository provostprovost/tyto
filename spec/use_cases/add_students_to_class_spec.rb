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
  end

  it "returns correct errors" do

  end

  it "correctly adds students to a classroom" do

  end
end
