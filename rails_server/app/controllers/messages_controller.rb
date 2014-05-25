class MessagesController < ApplicationController
  def index
    chats = []
    params[:classroom_ids].each do |id|
      classroom = Tyto.db.get_classroom(id)
      chat = Tyto.db.get_past_messages(id, 30)
      chats.push({name: classroom.name, id: classroom.id, chat: chat})
    end
    render json: chats
  end

  def create
    message = Tyto.db.create_message(message_params)
    render json: message
  end

  def message_params
    params.permit(:username, :classroom_id, :message)
  end
end
