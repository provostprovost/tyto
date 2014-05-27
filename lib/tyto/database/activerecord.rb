require "active_record"
require "yaml"

module Tyto
  module Database
    class Persistence

      def initialize(env)
        ActiveRecord::Base.establish_connection(
          YAML.load_file('db/config.yml')[env]
        )
      end

      def seed_database
        require_relative '../../../db/seeds.rb'
      end

      def clear_everything
        Assignment.delete_all
        Chapter.delete_all
        Classroom.delete_all
        ClassroomsUsers.delete_all
        Course.delete_all
        Question.delete_all
        Invite.delete_all
        Response.delete_all
        Session.delete_all
        Student.delete_all
        Teacher.delete_all
        UsersQuestions.delete_all
      end
    end
  end
end
