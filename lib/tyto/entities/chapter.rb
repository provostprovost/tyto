module Tyto
  class Chapter < Course
    attr_reader :parent_id, :course_id, :subname, :video_url
    validates_presence_of :parent_id
  end
end
