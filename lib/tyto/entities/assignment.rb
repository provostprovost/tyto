module Tyto
  class Assignment < Entity
    attr_reader :id,
                :student_id,
                :chapter_id,
                :classroom_id,
                :complete,
                :assignment_size,
                :teacher_id,
                :name,
                :questions_answered,
                :current_streak,
                :longest_streak,
                :current_question_text
    validates_presence_of :id, :student_id, :chapter_id, :classroom_id, :assignment_size, :teacher_id
  end
end
