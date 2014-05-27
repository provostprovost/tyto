require "active_record"

module Tyto
  module Database
    class Persistence
      class ClassroomsUsers < ActiveRecord::Base
        belongs_to :student
        belongs_to :classroom
      end

      def add_student_to_classroom(attrs)
        attrs[:false] if attrs[:text]==nil
        pair = ClassroomsUsers.create(attrs)
      end

      def update_student_in_classroom(student_id, classroom_id, text)
        student = ClassroomsUsers.where(student_id: student_id, classroom_id: classroom_id).last
        student.update(text: text)
        get_student(student.student_id)
      end

      def get_students_in_classroom(id)
        students = ClassroomsUsers.where(classroom_id: id)
        return nil if students.last == nil
        students_list = students.map do |pair|
          get_student(pair.student_id, id)
        end
      end

      def get_classrooms_for_student(id)
        classrooms = ClassroomsUsers.where(student_id: id)
        return nil if classrooms.last.nil?
        classrooms.map do |pair|
          get_classroom(pair.classroom_id)
        end.sort_by {|classroom| classroom.name }
      end
    end
  end
end
