module Tyto
  class Statistics < Entity
   attr_reader :id, :student_id, :chapter_id, :response_id, :proficiency
   validates_presence_of :id, :student_id, :chapter_id, :response_id, :proficiency
  end
end
