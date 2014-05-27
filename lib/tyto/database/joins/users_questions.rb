require "active_record"

module Tyto
  module Database
    class Persistence
      class UsersQuestions < ActiveRecord::Base
        belongs_to :student
        belongs_to :assignment
        belongs_to :chapter
        belongs_to :question
      end

      def get_last_question(attrs)
        last = UsersQuestions.find_by(attrs)
        return nil if last == nil
        question = get_question(last.question_id)
      end

      def update_last_question(attrs)
        last = UsersQuestions.find_by(student_id: attrs[:student_id], assignment_id: attrs[:assignment_id])
        if last == nil
          last = UsersQuestions.create(attrs)
          question = get_question(last.question_id)
        else
          last.question_id = attrs[:question_id]
          last.save
          question = get_question(last.question_id)
        end
      end
    end
  end
end
