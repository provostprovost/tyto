class ChaptersController < ApplicationController
  def index
    classroom = Tyto.db.get_classroom_from_name(params[:name])
    subtopics = Tyto.db.get_subtopics_from_course(classroom.course_id)
    render json: subtopics
  end

end
