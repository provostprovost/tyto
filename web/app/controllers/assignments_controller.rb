class AssignmentsController < ApplicationController
  before_action :signed_in_user,  only: [:show]
  before_action :correct_user,    only: [:show]

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

  private

  def signed_in_user
    redirect_to "/signin", notice: "Please sign in." unless !!session[:app_session_id]
  end

  def correct_user
    current_session = Tyto.db.get_session(session[:app_session_id].to_i)
    current_assignment = Tyto.db.get_assignment(params[:id])
    redirect_to root_url, notice: "Incorrect user." unless current_session.student_id == current_assignment.student_id
  end
end
