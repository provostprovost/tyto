class StudentsController < ApplicationController
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
end
