require 'pry-debugger'
class TeachersController < ApplicationController
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
  end

  private

  def teacher_params
    params.permit(:username,
                  :email,
                  :phone_number,
                  :password,
                  :password_confirmation)
  end
end
