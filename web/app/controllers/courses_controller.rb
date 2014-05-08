class CoursesController < ApplicationController
  def show
    render json: Tyto.db.get_course(params[:chapter_id])
  end
end
