module Tyto
  class AcceptInvite < UseCase
    def run(inputs)
      session = Tyto.db.get_session(inputs[:session_id])
      return failure(:session_not_found) if session==nil
      student_id = session.student_id
      student = Tyto.db.get_student(student_id)
      invite = Tyto.db.get_invite_from_email_and_code(student.email, inputs[:code])
      return failure(:invite_not_found) if invite == nil
      return failure(:invite_already_accepted) if invite.accepted == true
      invite = Tyto.db.accept_invite(invite.id)
      classroom_id = invite.classroom_id
      classroom_user = Tyto.db.add_student_to_classroom(student_id: student_id,
                                                        classroom_id: classroom_id
                                                                        )
      success :classroom_user => classroom_user, :invite => invite

   end
  end
end
