module Tyto
  class SignIn < UseCase
    def run(inputs)
      # teacher boolean
      # email address
      # password
      if inputs[:teacher]
        user = Tyto.db.get_teacher_from_email(inputs[:email])
      else
        user = Tyto.db.get_student_from_email(inputs[:email])
      end

      return failure :user_not_found if user.nil?

      return failure :incorrect_password if !user.correct_password?(inputs[:password])
    end
  end
end
