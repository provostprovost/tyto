module Tyto
  class SignIn < UseCase
    def run(inputs)
      session_attrs = { teacher_id: nil, student_id: nil }
      if inputs[:teacher]
        user = Tyto.db.get_teacher_from_email(inputs[:email])
        session_attrs[:teacher_id] = user.id if !user.nil?
      else
        user = Tyto.db.get_student_from_email(inputs[:email])
        session_attrs[:student_id] = user.id if !user.nil?
      end

      return failure :user_not_found if user.nil?

      return failure :incorrect_password if !user.correct_password?(inputs[:password])

      session = Tyto.db.create_session(session_attrs)

      success :session_id => session.id, :user => user
    end
  end
end
