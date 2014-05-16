class ClassroomsController < ApplicationController
  before_action :signed_in_user

  def index
    current_session = Tyto.db.get_session(session[:app_session_id].to_i)
    if current_session.student_id
      @classrooms = Tyto.db.get_classrooms_for_student(current_session.student_id)
    else
      @classrooms = Tyto.db.get_classrooms_for_teacher(current_session.teacher_id)
    end
    render json: @classrooms
  end

  def create
    params[:teacher_id] = Tyto.db.get_session(session[:app_session_id]).teacher_id
    classroom = Tyto.db.create_classroom(classroom_params)
    render json: classroom
  end

  def update
    params[:session_id] = session[:app_session_id]
    #NEED TO COME IN WITH AN ARRAY OF STUDENTS FROM TEACHER DASHBOARD#
    params[:students] = [params[:student_one], params[:student_two]]
    result = Tyto::AddStudentsToClass.run(students_params)
    if result.success?
        result.invite_ids.each do |invite_id|
          email = StudentMailer.classroom_invite(invite_id, result.classroom.id)
          email.deliver
        end
    end
    render json: result
  end

  private

  def classroom_params
    params.permit(:name,
                  :course_id,
                  :teacher_id)
  end

  def students_params
    params.permit(:classroom_id,
                  :session_id,
                  :students,
                  :student_one,
                  :student_two)
  end

  def signed_in_user
    redirect_to "/signin", notice: "Please sign in." unless !!session[:app_session_id]
  end
end
