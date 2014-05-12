class TeachersController < ApplicationController
  before_action :signed_in_user,  only: [:show]
  before_action :correct_user,    only: [:show]

  def new
  end

  def create
    result = Tyto::TeacherSignUp.run(teacher_params)
    if result.success?
      @teacher = result.teacher
      redirect_to "/teachers/#{@teacher.id}"
    else
      render 'new'
    end
  end

  def show
    @teacher = Tyto.db.get_teacher(params[:id])
    @classrooms = Tyto.db.get_classrooms_for_teacher(params[:id])
    @students = {}
    @classrooms.each do |classroom|
      @students[classroom.id] = Tyto.db.get_students_in_classroom(classroom.id)
    end
  end

  private

  def teacher_params
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
    redirect_to root_url, notice: "Incorrect user." unless current_session.teacher_id == params[:id].to_i
  end
end
