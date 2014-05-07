module Tyto
  class StudentSignUp < UseCase
    def run(inputs)
      return failure :email_address_not_valid unless inputs[:email] =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

      return failure :password_confirmation_does_not_match if inputs[:password] != inputs[:password_confirmation]

      phone_number = inputs[:phone_number].delete("^0-9").gsub(" ", "")

      return failure :phone_number_not_valid if phone_number.length < 10

      return failure :email_address_taken if Tyto.db.get_student_from_email(inputs[:email])

      return failure :phone_number_taken if Tyto.db.get_student_from_phone_number(inputs[:phone_number])

      student = Tyto.db.create_student(inputs)

      success :student => student
    end
  end
end
