module Tyto
  class Classroom < Entity
    attr_reader :id, :teacher_id, :course_id, :students, :name, :course_name
    validates_presence_of :teacher_id, :course_id, :name, :course_name
  end
end
