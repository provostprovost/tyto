module Tyto
  class Statistics < Entity
   attr_reader :id, :student_id, :chapter_id, :response_id, :proficiency, :current_streak, :longest_streak
   validates_presence_of :id, :student_id, :chapter_id, :response_id, :proficiency, :current_streak, :longest_streak
  end
end
