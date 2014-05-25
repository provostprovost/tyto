module Tyto
  class AcceptInvite < UseCase
    def run(inputs)
      session = Tyto.db.get_session(inputs[:session_id])
      return failure(:session_not_found) if session==nil
      student_id = session.student_id
      student = Tyto.db.get_student(student_id)
      invite = Tyto.db.get_invite(inputs[:invite_id])
      return failure(:invite_not_found) if invite == nil
      return failure(:invite_already_accepted) if invite.accepted == true
      invite = Tyto.db.accept_invite(invite.id)
      classroom_id = invite.classroom_id
      classroom_user = Tyto.db.add_student_to_classroom(student_id: student_id,
                                                        classroom_id: classroom_id
                                                  )
      students = Tyto.db.get_students_in_classroom(classroom_id)
      assignments = Tyto.db.get_assignments_for_classroom(classroom_id, students.first.id) if students != nil
      if assignments != nil
        assignments.each do |assignment|
          Tyto.db.create_assignment(student_id: student.id,
                                          chapter_id: assignment.chapter_id,
                                          classroom_id: classroom_id,
                                          teacher_id: assignment.teacher_id,
                                          assignment_size: assignment.assignment_size,
                                          deadline: assignment.deadline
            )
        end
      end
      success :classroom_user => classroom_user, :invite => invite

   end
  end
end
