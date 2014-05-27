require "active_record"

module Tyto
  module Database
    class Persistence
      def get_subtopics_from_course(course_id)
        subtopics = Chapter.where(course_id: course_id)
        subtopics = subtopics.select{|subtopic| subtopic.parent_id != nil}
        subtopics.map{|subtopic| get_chapter(subtopic.id)}
      end
    end
  end
end
