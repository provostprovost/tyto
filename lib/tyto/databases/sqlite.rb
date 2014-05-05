module Tyto
  module Database
    class SQLite
      def initialize
        ActiveRecord::Base.establish_connection(
            :adapter => 'sqlite3'
            :database => 'tytest.db'

          )
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

      ###########
      # Courses #
      ###########

      class Question < ActiveRecord::Base

      end

      def create_course(attrs)
      end

      def get_course(id)
      end

      def edit_course(attrs)
      end

      def delete_course(id)
      end

      ##############
      # Questions? #
      ##############

      class Response < ActiveRecord::Base

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

      class Assignment < ActiveRecord::Base

      end

      def create_response(attrs)
      end

      def get_response(id)
      end

      def edit_response(attrs)
      end

      def delete_response(id)
      end

      ############
      # Sessions #
      ############

      class Assignment < ActiveRecord::Base

      end

      def create_session(attrs)
      end

      def get_session(id)
      end

      def edit_session(attrs)
      end

      def delete_session(id)
      end

      #########
      # Users #
      #########

      class Assignment < ActiveRecord::Base

      end

      def create_user(attrs)
      end

      def get_user(id)
      end

      def edit_user(attrs)
      end

      def delete_user(id)
      end
    end
  end
end
