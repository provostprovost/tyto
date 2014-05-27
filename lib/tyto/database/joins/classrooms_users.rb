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

      def is_student_to_be_texted(student_id, classroom_id)
        if classroom_id == nil
          return false
        else
          student = ClassroomsUsers.where(student_id: student_id, classroom_id: classroom_id).last
          return false if student.text == nil
          return true if student.text == true
          return false if student.text == false
        end
      end

      def get_classroom_students_to_be_texted(classroom_id)
        students = ClassroomsUsers.where(classroom_id: classroom_id, text: true)
        students.map {|x| get_student(x.student_id) }
      end

      def delete_student_from_classroom(student_id, classroom_id)
        ClassroomsUsers.where(:classroom_id => classroom_id, student_id: student_id).destroy_all
        Assignment.where(:classroom_id => classroom_id, student_id: student_id).destroy_all
      end
    end
  end
end
