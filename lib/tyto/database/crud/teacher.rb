require "active_record"
require 'bcrypt'

module Tyto
  module Database
    class Persistence
      class Teacher < ActiveRecord::Base
        has_many :assignments
        has_many :classrooms
        has_many :invites
        include BCrypt
      end

      def create_teacher(attrs)
        attrs[:password_digest] = BCrypt::Password.create(attrs.delete(:password))
        attrs[:username] = attrs[:username].split.map(&:capitalize).join(' ')

        teacher = Tyto::Teacher.new(attrs)

        ar_teacher = Teacher.create(username: teacher.username,
                                    password_digest: teacher.password_digest,
                                    email: teacher.email,
                                    phone_number: teacher.phone_number)
        teacher.id = ar_teacher.id
        teacher
      end

      def get_teacher(id)
        teacher = Teacher.find_by(id: id)
        return nil if teacher == nil
        retrieved = Tyto::Teacher.new( id: teacher.id,
                                      username: teacher.username,
                                      password: "temp",
                                      email: teacher.email,
                                      phone_number: teacher.phone_number)
        retrieved.password_digest = BCrypt::Password.new(teacher.password_digest)
        retrieved
      end

      def edit_teacher(attrs)
        teacher = Teacher.find_by(id: attrs[:id])
        return nil if teacher == nil
        attrs.delete(:id)
        attrs[:password_digest] = BCrypt::Password.create(attrs.delete(:password)) if attrs[:password]
        teacher.update(attrs)
        new_teacher = Tyto::Teacher.new(id: teacher.id,
                                        username: teacher.username,
                                        password_digest: teacher.password_digest,
                                        email: teacher.email,
                                        phone_number: teacher.phone_number)
      end

      def delete_teacher(id)
        Teacher.destroy(id) if get_teacher(id)
      end
    end
  end
end
