require "active_record"

module Tyto
  module Database
    class Persistence
      class Session < ActiveRecord::Base
        belongs_to :student
        belongs_to :teacher
      end

      def create_session(attrs)
        ar_session = Session.create(attrs)
        session = Tyto::Session.new(id: ar_session.id,
                                    student_id: ar_session.student_id,
                                    teacher_id: ar_session.teacher_id)
      end

      def get_session(id)
        ar_session = Session.find_by(id: id)
        return nil if ar_session == nil
        session = Tyto::Session.new(id: ar_session.id,
                                    student_id: ar_session.student_id,
                                    teacher_id: ar_session.teacher_id)
      end

      def delete_session(id)
        Session.destroy(id) if get_session(id)
      end
    end
  end
end
