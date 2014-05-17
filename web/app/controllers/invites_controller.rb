class InvitesController < ApplicationController
  before_action :signed_in_user,  only: [:index, :create, :update]

  def index
    current_session = Tyto.db.get_session(session[:app_session_id].to_i)
    if current_session.student_id
      @invites = Tyto.db.get_invites_for_student(current_session.student_id)
    else
      @invites = Tyto.db.get_invites_for_teacher(current_session.teacher_id)
    end
    render json: @invites
  end

  def create
    params[:session_id] = session[:app_session_id]
    result = Tyto::AddStudentsToClass.run(create_invite_params)
    render json: result
  end

  def update
    params[:session_id] = session[:app_session_id]
    result = Tyto::AcceptInvite.run(session_id: params[:session_id], invite_id: params[:id])
    render json: result
  end

  private

  def create_invite_params
    params.permit(:session_id, :classroom_id, :students)
  end

  def signed_in_user
    redirect_to "/signin", notice: "Please sign in." unless !!session[:app_session_id]
  end
end
