class StudentMailer < ActionMailer::Base
  # default from: "dontreply@tyto.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_mailer.classroom_invite.subject
  #
  def classroom_invite(invite_id, classroom_id)
    @invite = Tyto.db.get_invite(invite_id)
    @classroom = Tyto.db.get_classroom(classroom_id)
    @teacher = Tyto.db.get_teacher(@classroom.teacher_id)
    mail(
      from: "dontreply@tyto.com",
      to: @invite.email,
      subject: "Tyto: #{@teacher.username} invited you to #{@classroom.name}"
    )

  end
end
