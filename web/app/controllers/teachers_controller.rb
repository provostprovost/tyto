class TeachersController < ApplicationController
  def new
  end

  def create
    @teacher = Tyto.db.create_teacher(params)
    redirect_to "/teachers/#{@teacher.id}"
  end

  def show
    @teacher = Tyto.db.get_teacher(params[:id])
  end
end
