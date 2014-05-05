module Tyto
  class Response < Entity
    attr_reader :id, :correct, :question_id, :student_id, :assignment_id, :difficult
  end
end
