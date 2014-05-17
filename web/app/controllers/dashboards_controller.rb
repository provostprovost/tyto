class DashboardsController < ApplicationController
before_action :signed_in_user

  def index
    existing_session = Tyto.db.get_session(session[:app_session_id])
    if existing_session.student_id
      redirect_to "/students/#{existing_session.student_id}"
    elsif existing_session.teacher_id
      redirect_to "/teachers/#{existing_session.teacher_id}"
    else
      redirect_to root_url
    end
  end

  private

  def signed_in_user
    redirect_to "/signin", notice: "Please sign in." unless !!session[:app_session_id]
  end
end
