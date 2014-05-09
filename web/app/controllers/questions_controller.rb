class QuestionsController < ApplicationController
  def show
<<<<<<< HEAD
   render json: Tyto.db.get_question(params[:id])
=======
    render json: Tyto.db.get_question(params[:id])
>>>>>>> b3520a6480e613a4cdb5aa8224bc4af894222136
  end
end
