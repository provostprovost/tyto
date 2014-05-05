module Tyto
  class Course < Entity
    attr_reader :id, :teacher_id
    attr_accessor :children_ids, :questions, :name
    validates_presence_of :id, :name, :teacher_id
  end
end
