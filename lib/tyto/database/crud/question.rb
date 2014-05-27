require "active_record"

module Tyto
  module Database
    class Persistence
      class Question < ActiveRecord::Base
        belongs_to :chapter
        has_many :responses
      end

      def create_question(attrs)
        ar_question = Question.create(attrs)
        attrs[:id] = ar_question.id
        question = Tyto::Question.new(attrs)
      end

      def get_question(id)
        question = Question.find_by(id: id)
        return nil if question == nil
        new_question = Tyto::Question.new(question: question.question,
                                          id: question.id,
                                          level: question.level,
                                          answer: question.answer,
                                          chapter_id: question.chapter_id)
      end

      def edit_question(attrs)
        question = Question.find_by(id: attrs[:id])
        return nil if question == nil
        attrs.delete(:id)
        question.update(attrs)
        question = Tyto::Question.new(id: question.id,
                                      level: question.level,
                                      answer: question.answer,
                                      chapter_id: question.chapter_id)
      end

      def delete_question(id)
        Question.destroy(id)
      end
    end
  end
end
