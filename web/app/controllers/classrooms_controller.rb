class ClassroomsController < ApplicationController

  def create
    params[:teacher_id] = Tyto.db.get_session(session[:app_session_id]).teacher_id
    classroom = Tyto.db.create_classroom(classroom_params)
    render json: classroom
  end

  def update
    params[:session_id] = session[:app_session_id]
    params[:students] = [params[:student_one], params[:student_two]]
    result = Tyto::AddStudentsToClass.run(students_params)
    if result.success?
        result.invite_ids.each do |x|
          email = StudentMailer.classroom_invite(x, result.classroom.id)
          email.deliver
        end
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
                  :session_id,
                  :students,
                  :student_one,
                  :student_two)

  end
end
