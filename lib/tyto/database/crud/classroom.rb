require "active_record"

module Tyto
  module Database
    class Persistence
      class Classroom < ActiveRecord::Base
        belongs_to :teacher
        belongs_to :course
        has_many :invites
        has_many :assignments
        has_many :messages
      end

      def create_classroom(attrs)
        attrs[:course_id] = attrs[:course_id].to_i
        classroom = Classroom.create(attrs)
        Tyto::Classroom.new(  id:         classroom.id,
                              course_id:  classroom.course_id,
                              teacher_id: classroom.teacher_id,
                              name: classroom.name )
      end

      def get_classroom(id)
        classroom = Classroom.find_by(id: id)
        return nil if classroom == nil
        Tyto::Classroom.new(  id:         classroom.id,
                              course_id:  classroom.course_id,
                              teacher_id: classroom.teacher_id,
                              name: classroom.name,
                              course_name: get_course(classroom.course_id).name )
      end

      def delete_classroom(id)
        Classroom.destroy(id)
      end
    end
  end
end
