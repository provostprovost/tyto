module Tyto
  class Class < Entity
    attr_reader :teacher_id, :course_id
    attr_accessor :students
    validates_presence_of :teacher_id, :course_id
  end
end
