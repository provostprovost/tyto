module Tyto
  class Invite < Entity
    attr_reader :id, :teacher_id, :student_id, :classroom_id, :code, :accepted
    validates_presence_of :id, :teacher_id, :student_id, :accepted, :classroom_id, :code
  end
end
