require "active_record"

module Tyto
  module Database
    class Persistence
      def get_assignments_for_classroom(classroom_id, student_id)
        assignments = Assignment.where(classroom_id: classroom_id, student_id: student_id).order(:deadline)
        return nil if assignments.last == nil
        assignments.map { |assignment| get_assignment(assignment.id) }
      end

      def get_assignments_for_student(student_id)
        assignments = Assignment.where(student_id: student_id).order(:deadline)
        return nil if assignments.last == nil
        assignments.map { |assignment| get_assignment(assignment.id) }
      end
    end
  end
end
