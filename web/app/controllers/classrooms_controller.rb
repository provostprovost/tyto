class ClassroomsController < ApplicationController

  def create
    params[:teacher_id] = Tyto.db.get_session(session[:app_session_id]).teacher_id
    classroom = Tyto.db.create_classroom(classroom_params)
    render json: classroom
  end

  def update
    params[:teacher_id] = Tyto.db.get_session(session[:app_session_id]).teacher_id
    params[:students] = [params[:student_one], params[:student_two]]
    result = Tyto.db.AddStudentsToClass(students_params)
    if result.success?
      StudentMailer.classroom_invite(result.invite_ids, result.classroom.id)
    end
    render json: result
  end

  def classroom_params
    params.permit(:name,
                  :course_id,
                  :teacher_id)
  end

  def students_params
    params.permit(:classroom_id,
                  :teacher_id,
                  :students)

  end
end
