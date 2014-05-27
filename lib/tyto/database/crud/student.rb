require "active_record"
require 'bcrypt'

module Tyto
  module Database
    class Persistence
      class Student < ActiveRecord::Base
        has_many :responses
        has_many :assignments
        has_many :invites
        belongs_to :classroom
        include BCrypt
      end

      def create_student(attrs)
        attrs[:username] = attrs[:username].split.map(&:capitalize).join(' ')
        attrs[:password_digest] = BCrypt::Password.create(attrs.delete(:password))

        student = Tyto::Student.new(attrs)
        ar_student = Student.create(username: student.username,
                                    password_digest: student.password_digest,
                                    email: student.email,
                                    phone_number: student.phone_number)
        student.id = ar_student.id
        student
      end

      def get_student(id, classroom_id=nil)
        student = Student.find_by(id: id)
        return nil if student == nil
        retrieved = Tyto::Student.new( id: student.id,
                                      username: student.username,
                                      password: "temp",
                                      email: student.email,
                                      phone_number: student.phone_number,
                                      struggling: is_student_struggling(student.id, classroom_id),
                                      text: is_student_to_be_texted(student.id, classroom_id))
        retrieved.password_digest = BCrypt::Password.new(student.password_digest)
        retrieved
      end

      def edit_student(attrs)
        student = Student.find_by(id: attrs[:id])
        return nil if student == nil
        attrs.delete(:id)
        attrs[:password_digest] = BCrypt::Password.create(attrs.delete(:password)) if attrs[:password]
        student.update(attrs)
        new_student = Tyto::Student.new(id: student.id,
                                        username: student.username,
                                        password_digest: student.password_digest,
                                        email: student.email,
                                        phone_number: student.phone_number)
      end

      def delete_student(id)
        Student.destroy(id) if get_student(id)
      end
    end
  end
end
