module Tyto
  class SignIn < UseCase
    def run(inputs)
      # teacher boolean
      # email address
      # password
      if inputs[:teacher]
        user = get_teacher_from_username(inputs[:username])
      else
        user = get_student_from_username(inputs[:username])
      end
    end
  end
end
