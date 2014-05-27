require "active_record"

module Tyto
  module Database
    class Persistence
      def get_proficiency(response_id)
        response = get_response(response_id)
        student_id = response.student_id
        chapter_id = response.chapter_id
        assignment = get_assignment(response.assignment_id)
        responses = Response.where(student_id: student_id, chapter_id: chapter_id).order(:created_at).to_a

        responses.map! do |response|
          question = get_question(response.question_id)
          if response.correct
            question.level
          else
            -1 + 0.5 * (question.level - 1)
          end
        end

        score(responses, assignment.assignment_size)
      end

      def get_last_proficiency_score(student_id, chapter_id, actual=nil)
        responses = Response.where(student_id: student_id, chapter_id: chapter_id)
        return 0 if responses.last == nil
        response = responses.last(2)[0]
        response = responses.last if actual
        if response.proficiency
          return response.proficiency
        else
          return 0
        end
      end

      def ema(array, alpha_n=1)
        alpha = alpha_n.to_f / array.count
        n = (1..array.count).to_a.map{|tidx| (1 - alpha) ** (tidx - 1) * array[array.count - tidx]}.sum
        d = (1..array.count).to_a.map{|tidx| (1 - alpha) ** (tidx -1)}.sum
        n / d
      end

      def score(array, assignment_size, alpha_n=1)
        multiplier = array.size / (assignment_size.to_f / 3)
        multiplier = 1 if multiplier > 1
        score = Math.log(ema(array, alpha_n)+1) * multiplier
        if score > 0
          return score
        else
          return 0
        end
      end
    end
  end
end
