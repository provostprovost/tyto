require "active_record"

module Tyto
  module Database
    class Persistence
      def get_responses_for_assignment(assignment_id)
        Response.where(assignment_id: assignment_id).order(:created_at)
      end

      def get_difficult_questions_for_chapter(chapter_id, classroom_id)
        students = get_students_in_classroom(classroom_id)
        difficult = {}
        students.each do |student|
          responses = Response.where(student_id: student.id, chapter_id: chapter_id, difficult: true)
          responses.each do |response|
            question = get_question(response.question_id)
            if difficult[question.question]
              difficult[question.question] += 1
            else
              difficult[question.question] = 1
            end
          end
        end
        difficult.to_a.sort_by{|element| element[1]}.reverse
      end
    end
  end
end
