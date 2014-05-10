class AssignmentsController < ApplicationController

  def create
    params[:session_id] = session[:app_session_id]
    result = Tyto::AssignHomework.run(params)
    redirect_to '/teachers/#{result.classroom.teacher_id}'
  end

  def show
    @assignment = Tyto.db.get_assignment(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @assignment }
    end
  end
end
