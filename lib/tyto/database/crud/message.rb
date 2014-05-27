require "active_record"

module Tyto
  module Database
    class Persistence
      class Message < ActiveRecord::Base
        belongs_to :classrooms
      end

      def create_message(attrs)
        message = Message.create(attrs)
        attrs[:id] = message.id
        Tyto::Message.new(attrs)
      end

      def get_message(id)
        message = Message.where(id: id).last
        return nil if message==nil
        Tyto::Message.new(classroom_id: message.classroom_id, username: message.username, message: message.message)
      end
    end
  end
end
