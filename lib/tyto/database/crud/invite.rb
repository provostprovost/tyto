require "active_record"

module Tyto
  module Database
    class Persistence
      class Invite < ActiveRecord::Base
        belongs_to :teacher
        belongs_to :student
        belongs_to :classroom
      end

      def create_invite(attrs)
        invite = Invite.create(attrs)
        Tyto::Invite.new( id:           invite.id,
                          email:        invite.email,
                          teacher_id:   invite.teacher_id,
                          classroom_id: invite.classroom_id,
                          accepted:     invite.accepted,
                          teacher_name: get_teacher(invite.teacher_id).username,
                          course_name:  get_course(get_classroom(invite.classroom_id).course_id).name
                              )
      end

      def get_invite(id)
        invite = Invite.find_by(:id => id)
        return nil if invite == nil
        Tyto::Invite.new(id:           invite.id,
                         email:        invite.email,
                         teacher_id:   invite.teacher_id,
                         classroom_id: invite.classroom_id,
                         accepted:     invite.accepted,
                         teacher_name: get_teacher(invite.teacher_id).username,
                         course_name:  get_course(get_classroom(invite.classroom_id).course_id).name
                         )
      end

      def edit_invite(attrs)
        invite = Invite.find_by(id: attrs[:id])
        return nil if invite == nil
        attrs.delete(:id)
        invite.update(attrs)
        Tyto::Invite.new(id:           invite.id,
                         email:        invite.email,
                         teacher_id:   invite.teacher_id,
                         classroom_id: invite.classroom_id,
                         accepted:     invite.accepted,
                         teacher_name: get_teacher(invite.teacher_id).username,
                         course_name:  get_course(get_classroom(invite.classroom_id).course_id).name
                         )
      end

      def delete_invite(id)
        Invite.destroy(id)
      end
    end
  end
end
