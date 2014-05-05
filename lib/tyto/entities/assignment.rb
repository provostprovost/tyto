module Tyto
  class Assignment < Entity
    attr_reader :id, :student_id, :teacher_id, :chapter_id
    validates_presence_of :id, :student_id, :teacher_id, :chapter_id
  end
end
