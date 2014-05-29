require "active_record"

module Tyto
  module Database
    class Persistence
      class Response < ActiveRecord::Base
        belongs_to :question
        belongs_to :student
        belongs_to :assignment
        belongs_to :chapter
      end

      def create_response(attrs)
        ar_response = Response.create(attrs)
        attrs[:id] = ar_response.id
        attrs[:proficiency] = get_proficiency(ar_response.id) if attrs[:proficiency] == nil
        ar_response.proficiency = attrs[:proficiency]
        ar_response.save
        response = Tyto::Response.new(attrs)
      end

      def get_response(id)
        response = Response.find_by(id: id)
        return nil if response == nil
        new_response = Tyto::Response.new(id: response.id,
                                          correct: response.correct,
                                          question_id: response.question_id,
                                          chapter_id: response.chapter_id,
                                          student_id: response.student_id,
                                          assignment_id: response.assignment_id,
                                          difficult: response.difficult,
                                          proficiency: response.proficiency,
                                          answer: response.answer )
      end
    end
  end
end
