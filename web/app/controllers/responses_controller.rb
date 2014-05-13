require 'pry-debugger'

class ResponsesController < ApplicationController
  def create
    params[:session_id] = session[:app_session_id]
    result = Tyto::AnswerQuestion.run(response_params)
    render json: result
  end

  def response_params
    params.permit(:session_id,
                  :assignment_id,
                  :difficult,
                  :answer)
  end
end
