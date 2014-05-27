require "active_record"

module Tyto
  module Database
    class Persistence
      def accept_invite(id)
        edit_invite(id: id, accepted: true)
      end

      def get_invites_for_student(id)
        student = get_student(id)
        invites = Invite.where(email: student.email, accepted: false)
        invites.map {|invite| get_invite(invite.id)}
      end

      def get_invites_for_teacher(id)
        invites = Invite.where(teacher_id: id, accepted: false)
        invites.map {|invite| get_invite(invite.id)}
      end
    end
  end
end
