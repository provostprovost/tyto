require "active_record"

module Tyto
  module Database
    class Persistence
      def get_classrooms_for_teacher(teacher_id)
        classrooms = Teacher.find_by(id: teacher_id).classrooms
        classrooms.map { |classroom| get_classroom(classroom.id) }
      end

      def get_classroom_from_name(name)
        classroom = Classroom.find_by(:name => name)
        return nil if classroom == nil
        Tyto::Classroom.new(  id:         classroom.id,
                              course_id:  classroom.course_id,
                              teacher_id: classroom.teacher_id,
                              name: classroom.name )
      end
    end
  end
end
