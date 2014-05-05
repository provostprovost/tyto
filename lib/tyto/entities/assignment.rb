module Tyto
  class Assignment < Entity
    attr_reader :id, :student_id, :teacher_id, :chapter_id
    attr_accessor :complete, :assignment_size
    validates_presence_of :id, :student_id, :teacher_id, :chapter_id
  end
end
