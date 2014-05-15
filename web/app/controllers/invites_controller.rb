class InvitesController < ApplicationController
  def create
    params[:session_id] = session[:app_session_id]
    result = Tyto::AddStudentsToClass.run(invite_params)
    render json: result
  end

  def update
    params[:session_id] = session[:app_session_id]
    result = Tyto::AcceptInvite.run(invite_params)
    render json: result
  end

  private

  def invite_params
    params.permit(:session_id, :classroom_id, :students, :invite_id)
  end
end
