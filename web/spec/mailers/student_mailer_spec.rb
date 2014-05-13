require "spec_helper"

describe StudentMailer do
  before do
    @teacher = Tyto.db.create_teacher(username: "Teacher Guy",
                                      password: "98765",
                                      email:    "teacher@email.com",
                                      phone_number: "1234567890" )
    @course = Tyto.db.create_course(name: "algebra")

    @classroom = Tyto.db.create_classroom( teacher_id: @teacher.id,
                                        course_id:  @course.id,
                                        name: "Period 1" )
    @invite =  Tyto.db.create_invite(email: 'a@gmail.com',
                              teacher_id: @teacher.id,
                              classroom_id: @classroom.id,
                              code: '1234',
                              accepted: false)
    @invite_two = Tyto.db.create_invite(email: 'b@gmail.com',
                              teacher_id: @teacher.id,
                              classroom_id: @classroom.id,
                              code: '1234',
                              accepted: false)
    @invite_ids = [@invite.id, @invite_two.id]
  end
  describe "classroom_invite" do
    let(:mail) { StudentMailer.classroom_invite(@invite_ids, @classroom.id) }

    it "renders the headers" do
      mail.subject.should eq("Tyto: Teacher Guy invited you to Period 1")
      mail.to.should eq(["a@gmail.com"])
      mail.from.should eq(["dontreply@tyto.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hello")
    end
  end

end
