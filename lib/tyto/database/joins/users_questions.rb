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
    end
  end
end
