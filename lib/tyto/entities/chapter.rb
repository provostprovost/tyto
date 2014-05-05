module Tyto
  class Chapter < Course
    attr_reader :parent_id
    validates_presence_of :parent_id
  end
end
