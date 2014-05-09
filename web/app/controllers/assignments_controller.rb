class AssignmentsController < ApplicationController

  def create
    params[:session_id] = session[:app_session_id]
    result = Tyto::AssignHomework.run(params)
    # render json: result
    redirect_to '/teachers/#{result.classroom.teacher_id}'
  end

  def show

  end
end
