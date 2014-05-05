require "active_record"
require "yaml"


module Tyto
  module Database
    class SQLite
      def initialize
        dbconfig = YAML::load(File.open('db/config.yml'))
        ActiveRecord::Base.establish_connection(dbconfig["test"])
      end

      ###############
      # Assignments #
      ###############

      class Assignment < ActiveRecord::Base

      end

      def create_assignment(attrs)
      end

      def get_assignment(id)
      end

      def edit_assignment(attrs)
      end

      def delete_assignment(id)
      end

      ############
      # Chapters #
      ############

      class Chapter < ActiveRecord::Base

      end

      def create_chapter(attrs)
      end

      def get_chapter(id)
      end

      def edit_chapter(attrs)
      end

      def delete_chapter(id)
      end

      ###########
      # Classes #
      ###########

      class Class < ActiveRecord::Base

      end

      def create_class(attrs)
      end

      def get_class(id)
      end

      def edit_class(attrs)
      end

      def delete_class(attrs)
      end

      ##############
      # Questions? #
      ##############

      class Question < ActiveRecord::Base

      end

      def create_question(attrs)
      end

      def get_question(id)
      end

      def edit_question(attrs)
      end

      def delete_question(id)
      end

      #############
      # Responses #
      #############

      class Response < ActiveRecord::Base

      end

      def create_response(attrs)
      end

      def get_response(id)
      end

      def edit_response(attrs)
      end

      def delete_response(id)
      end

      ####################
      # Student Sessions #
      ####################

      class StudentSession < ActiveRecord::Base

      end

      def create_student_session(attrs)
      end

      def get_student_session(id)
      end

      def edit_student_session(attrs)
      end

      def delete_student_session(id)
      end

      ############
      # Students #
      ############

      class Student < ActiveRecord::Base

      end

      def create_student(attrs)
      end

      def get_student(id)
      end

      def edit_student(attrs)
      end

      def delete_student(id)
      end

      ####################
      # Teacher Sessions #
      ####################

      class TeacherSession < ActiveRecord::Base

      end

      def create_teacher_session(attrs)
      end

      def get_teacher_session(id)
      end

      def edit_teacher_session(attrs)
      end

      def delete_teacher_session(id)
      end

      ############
      # Teachers #
      ############

      class Teacher < ActiveRecord::Base

      end

      def create_teacher(attrs)
      end

      def get_teacher(id)
      end

      def edit_teacher(attrs)
      end

      def delete_teacher(id)
      end
    end
  end
end
