module Tyto
  class UpdateStudent < UseCase
    def run(inputs)
      return failure :email_address_not_valid unless inputs[:email] =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

      return failure :password_confirmation_does_not_match if inputs[:password] != inputs[:password_confirmation]

      phone_number = inputs[:phone_number].delete("^0-9").gsub(" ", "")

      return failure :phone_number_not_valid if phone_number.length < 10

      student = Tyto.db.get_student(inputs[:id])

      email_student = Tyto.db.get_student_from_email(inputs[:email])
      return failure :email_address_taken if email_student && student.id != email_student.id

      phone_number_student = Tyto.db.get_student_from_phone_number(inputs[:phone_number])
      return failure :phone_number_taken if phone_number_student && student.id != phone_number_student.id

      inputs.delete(:password_confirmation)

      edited_student = Tyto.db.edit_student(inputs)

      success :student => edited_student
    end
  end
end
