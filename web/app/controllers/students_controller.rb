class StudentsController < ApplicationController
  before_action :signed_in_user,  only: [:show, :edit, :update]
  before_action :correct_user,    only: [:show, :edit, :update]

  def new
    if session[:app_session_id]
      existing_session = Tyto.db.get_session(session[:app_session_id])
      if existing_session.student_id
        redirect_to "/students/#{existing_session.student_id}"
      elsif existing_session.teacher_id
        redirect_to "/teachers/#{existing_session.teacher_id}"
      else
        redirect_to root_url
      end
    end
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

  def edit
    @student = Tyto.db.get_student(params[:id])
  end

  def update
    params[:session_id] = session[:app_session_id]
    @student = Tyto.db.get_student(params[:id])
    result = Tyto::UpdateStudent.run(student_params)
    if result.success?
      flash[:success] = "Account updated."
      redirect_to "/students/#{@student.id}"
    else
      flash.now[:error] = result.error
      render 'edit'
    end
  end

  private

  def student_params
    params.permit(:username,
                  :email,
                  :phone_number,
                  :password,
                  :password_confirmation,
                  :session_id)
  end

  def signed_in_user
    redirect_to "/signin", notice: "Please sign in." unless !!session[:app_session_id]
  end

  def correct_user
    current_session = Tyto.db.get_session(session[:app_session_id].to_i)
    redirect_to root_url, notice: "Incorrect user." unless current_session.student_id == params[:id].to_i
  end
end
