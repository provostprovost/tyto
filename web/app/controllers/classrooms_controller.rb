class ClassroomsController < ApplicationController

  def create
    params[:teacher_id] = Tyto.db.get_session(session[:app_session_id]).teacher_id
    classroom = Tyto.db.create_classroom(classroom_params)
    redirect_to '/teachers/#{classroom.teacher_id}'
  end

  def classroom_params
    params.permit(:name,
                  :course_id,
                  :teacher_id)
  end
end
