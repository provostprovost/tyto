require "active_record"

module Tyto
  module Database
    class Persistence
      def get_next_question(proficiency, student_id, chapter_id)
        questions = Question.where(chapter_id: chapter_id)
        return nil if questions.last == nil
        responses = Response.where(student_id: student_id, chapter_id: chapter_id)
        unanswered = []
        if responses != []
          questions.each do |x|
            answered = false
            responses.each do |y|
              answered=true if x.id==y.question_id
            end
            unanswered.push(x) if answered == false
          end
        else
          unanswered = questions
        end
          if proficiency < 0.4
            level = 1
          elsif proficiency < 0.7
            level = 2
          elsif proficiency < 0.9
            level = 3
          else
            level = 4
          end
        selected_questions = unanswered.select{|x| x.level == level}
        if selected_questions == []
          selected_questions = questions.select{|x| x.level == level}
        end
        index = rand(0...selected_questions.length)
        get_question(selected_questions[index].id)
      end
    end
  end
end
