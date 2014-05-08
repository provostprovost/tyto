class StudentsController < ApplicationController
  def new
  end

  def create
    @student = Tyto.db.create_student(params)
    redirect_to "/students/#{@student.id}"
  end

  def show
    @student = Tyto.db.get_student(params[:id])
  end
end
