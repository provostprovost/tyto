require "active_record"

module Tyto
  module Database
    class Persistence
      def get_longest_streak(student_id, chapter_id)
        responses = Response.where(student_id: student_id, chapter_id: chapter_id).order(:created_at)

        counter = 0
        current_response = responses.where(correct: true).last
        longest_streak = 0
        streak = 0
        until counter == responses.length
          streak += 1 if responses[counter].correct == true
          streak = 0 if responses[counter].correct == false
          longest_streak = streak if streak > longest_streak
          counter += 1
        end
        return longest_streak
      end

      def current_chapter_streak(student_id, chapter_id)
        responses = Response.where(student_id: student_id, chapter_id: chapter_id).order(:created_at)
        streak = 0
        counter = responses.size - 1
        while counter >= 0
          break if !responses[counter].correct
          counter -= 1
          streak += 1
        end
        streak
      end
    end
  end
end
