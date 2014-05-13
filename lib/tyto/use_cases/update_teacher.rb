module Tyto
  class UpdateTeacher < UseCase
    def run(inputs)
      session = Tyto.db.get_session(inputs[:session_id])

      return failure :session_not_found if session.nil?

      return failure :email_address_not_valid unless inputs[:email] =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

      return failure :password_confirmation_does_not_match if inputs[:password] != inputs[:password_confirmation]

      phone_number = inputs[:phone_number].delete("^0-9").gsub(" ", "")

      return failure :phone_number_not_valid if phone_number.length < 10

      teacher = Tyto.db.get_teacher(session.teacher_id)

      email_teacher = Tyto.db.get_teacher_from_email(inputs[:email])
      return failure :email_address_taken if email_teacher && teacher.id != email_teacher.id

      phone_number_teacher = Tyto.db.get_teacher_from_phone_number(inputs[:phone_number])
      return failure :phone_number_taken if phone_number_teacher && teacher.id != phone_number_teacher.id

      inputs.delete(:password_confirmation)

      edited_teacher = Tyto.db.edit_teacher(inputs)

      success :teacher => edited_teacher
    end
  end
end
