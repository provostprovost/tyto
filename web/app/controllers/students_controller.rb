class StudentsController < ApplicationController
  before_action :signed_in_user,  only: [:show]
  before_action :correct_user,    only: [:show]

  def new
  end

  def create
    result = Tyto::StudentSignUp.run(student_params)
    if result.success?
      @student = result.student
      redirect_to "/students/#{@student.id}"
    else
      render 'new'
    end
  end

  def show
    @student = Tyto.db.get_student(params[:id])
    @assignments = Tyto.db.get_assignments_for_student(params[:id])
  end

  private

  def student_params
    params.permit(:username,
                  :email,
                  :phone_number,
                  :password,
                  :password_confirmation)
  end

  def signed_in_user
    redirect_to "/signin", notice: "Please sign in." unless !!session[:app_session_id]
  end

  def correct_user
    current_session = Tyto.db.get_session(session[:app_session_id].to_i)
    redirect_to root_url, notice: "Incorrect user." unless current_session.student_id == params[:id]
  end
end
