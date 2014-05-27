require "active_record"

module Tyto
  module Database
    class Persistence
      def get_course_from_name(name)
        course = Course.find_by(:name => name)
        return nil if course == nil
        course = Tyto::Course.new(id: course.id, name: course.name)
      end
    end
  end
end
