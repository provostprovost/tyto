module Tyto
  class Assignment < Entity
    attr_reader :id, :student_id, :chapter_id, :class_id, :complete, :assignment_size
    validates_presence_of :id, :student_id, :chapter_id, :class_id
  end
end
