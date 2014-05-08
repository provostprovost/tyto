class QuestionsController < ApplicationController
  def show
    render json: Tyto.db.get_question(params[:question_id])
  end
end
