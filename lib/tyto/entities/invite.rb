module Tyto
  class Invite < Entity
    attr_reader :id, :teacher_id, :email, :classroom_id, :accepted, :teacher_name, :course_name
    validates_presence_of :id, :teacher_id, :email, :accepted, :classroom_id
  end
end
