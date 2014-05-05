module Tyto
  class Question < Entity
    attr_reader :id, :level, :question, :answer, :chapter_id
  end
end
