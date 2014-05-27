require "active_record"

module Tyto
  module Database
    class Persistence
      def get_past_messages(classroom_id, size)
        messages = Message.where(classroom_id: classroom_id).last(size)
        return [] if messages.last == nil
        messages.map{|message| get_message(message.id) }
      end
    end
  end
end
