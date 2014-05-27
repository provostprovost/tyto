require "active_record"

module Tyto
  module Database
    class Persistence
      def is_student_struggling(student_id, classroom_id)
        if classroom_id == nil
          assignments = Assignment.where(student_id: student_id, complete: true).last(5)
          return false if assignments.last == nil
          proficiencies = assignments.map{|assignment| get_assignment(assignment.id).proficiency}
          total_proficiency = 0.0
            proficiencies.each do |proficiency|
              total_proficiency += proficiency
            end
          average = total_proficiency / proficiencies.length
          return true if average < 0.6
          return false if average >= 0.6
        else
          assignments = Assignment.where(student_id: student_id, complete: true, classroom_id: classroom_id).last(5)
          return false if assignments.last == nil
          proficiencies = assignments.map{|assignment| get_assignment(assignment.id).proficiency}
          total_proficiency = 0.0
            proficiencies.each do |proficiency|
              total_proficiency += proficiency
            end
          average = total_proficiency / proficiencies.length
          return true if average < 0.6
          return false if average >= 0.6
        end
      end

      def get_student_from_email(email)
        student = Student.find_by(email: email)
        return nil if student.nil?
        retrieved = Tyto::Student.new( id: student.id,
                                      username: student.username,
                                      password: "temp",
                                      email: student.email,
                                      phone_number: student.phone_number)
        retrieved.password_digest = BCrypt::Password.new(student.password_digest)
        retrieved
      end

      def get_student_from_phone_number(phone_number)
        student = Student.find_by(phone_number: phone_number)
        return nil if student.nil?
        retrieved = Tyto::Student.new( id: student.id,
                                      username: student.username,
                                      password: "temp",
                                      email: student.email,
                                      phone_number: student.phone_number)
        retrieved.password_digest = BCrypt::Password.new(student.password_digest)
        retrieved
      end
    end
  end
end
