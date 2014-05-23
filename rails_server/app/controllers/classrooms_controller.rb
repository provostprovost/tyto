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
    params[:course_id] = Tyto.db.get_course_from_name(params[:course_name]).id
    classroom = Tyto.db.create_classroom(classroom_params)
    params[:classroom_id] = classroom.id
    invites = Tyto::AddStudentsToClass.run(params).invites
    render json: invites
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

  def update_text
    student = Tyto.db.update_student_in_classroom(params[:student_id], params[:classroom_id], params[:text])
    render json: student
  end

  private

  def classroom_params
    params.permit(:name,
                  :course_id,
                  :teacher_id)
  end

  def add_students_params
    params.permit(:teacher_id, :classroom_id, :students)

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
