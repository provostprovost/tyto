class TeachersController < ApplicationController
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
    @assignments = {}
    @studenthomework = {}
    @courses = Tyto.db.get_all_courses

    if @classrooms != nil
      @classrooms.each do |classroom|
          @students[classroom.id] = Tyto.db.get_students_in_classroom(classroom.id)
          if @students[classroom.id] != nil
          @assignments[classroom.id] = Tyto.db.get_assignments_for_classroom(classroom.id, @students[classroom.id].first.id)
          @studenthomework[classroom.id] = {}
            @students[classroom.id].each do |x|
              @studenthomework[classroom.id][x.id] = Tyto.db.get_assignments_for_classroom(classroom.id, x.id)
            end
          end
      end
    end
  end

  def edit
    @teacher = Tyto.db.get_teacher(params[:id])
  end

  def update
    params[:session_id] = session[:app_session_id]
    @teacher = Tyto.db.get_teacher(params[:id])
    result = Tyto::UpdateTeacher.run(teacher_params)
    if result.success?
      flash[:success] = "Account updated."
      redirect_to "/teachers/#{@teacher.id}"
    else
      flash.now[:error] = result.error
      render 'edit'
    end
  end

  private

  def teacher_params
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
    if current_session
      redirect_to root_url, notice: "Incorrect user." unless current_session.teacher_id == params[:id].to_i
    else
      redirect_to root_url
    end
  end
end
