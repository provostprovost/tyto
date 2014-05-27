require "active_record"

module Tyto
  module Database
    class Persistence
      def get_teacher_from_email(email)
        teacher = Teacher.find_by(email: email)
        return nil if teacher.nil?
        retrieved = Tyto::Teacher.new( id: teacher.id,
                                      username: teacher.username,
                                      password: "temp",
                                      email: teacher.email,
                                      phone_number: teacher.phone_number)
        retrieved.password_digest = BCrypt::Password.new(teacher.password_digest)
        retrieved
      end

      def get_teacher_from_phone_number(phone_number)
        teacher = Teacher.find_by(phone_number: phone_number)
        return nil if teacher.nil?
        retrieved = Tyto::Teacher.new( id: teacher.id,
                                      username: teacher.username,
                                      password: "temp",
                                      email: teacher.email,
                                      phone_number: teacher.phone_number)
        retrieved.password_digest = BCrypt::Password.new(teacher.password_digest)
        retrieved
      end
    end
  end
end
