class MessagesController < ApplicationController
  def index
    classroom_messages = {}
    params[:classroom_ids].each do |id|
      classroom_messages[id] = Tyto.db.get_past_message(id, 30)
    end
    render json: classroom_messages
  end

  def create
    message = Tyto.db.create_message(message_params)
    render json: message
  end

  def message_params
    params.permit(:username, :classroom_id, :message)
  end
end
