module Tyto
  class Class < Entity
    attr_reader :teacher_id, :course_id, :students
    validates_presence_of :teacher_id, :course_id
  end
end
