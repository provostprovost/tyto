class TeachersController < ApplicationController
  def new
  end

  def create
    @teacher = Tyto::TeacherSignUp.run(params).teacher
    redirect_to "/teachers/#{@teacher.id}"
  end

  def show
    @teacher = Tyto.db.get_teacher(params[:id])
  end
end
