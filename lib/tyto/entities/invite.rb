module Tyto
  class Invite < Entity
    attr_reader :id, :teacher_id, :email, :classroom_id, :code, :accepted
    validates_presence_of :id, :teacher_id, :email, :accepted, :classroom_id, :code
  end
end
