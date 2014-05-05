module Tyto
  class Course < Entity
    attr_reader :id, :name
    validates_presence_of :id, :name
  end
end
