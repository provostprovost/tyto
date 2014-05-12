class StudentMailer < ActionMailer::Base
  # default from: "dontreply@tyto.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_mailer.classroom_invite.subject
  #
  def classroom_invite(invite_ids, classroom_id)
    @invites = invite_ids.map {|x| Tyto.db.get_invite(x)}
    @classroom = Tyto.db.get_classroom(classroom_id)
    @teacher = Tyto.db.get_teacher(@classroom.teacher_id)
    @invites.each do |x|
      mail(
      from: "dontreply@tyto.com",
      to: x.email,
      subject: "Tyto: #{@teacher.username} invited you to #{@classroom.name}"
    )
    end
  end
end
