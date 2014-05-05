require "active_record"
require "yaml"
require 'pry-debugger'

module Tyto
  module Database
    class SQLite
      def initialize
        dbconfig = YAML::load(File.open('db/config.yml'))
        ActiveRecord::Base.establish_connection(dbconfig["test"])
      end

      def delete_all

      end

      ###############
      # Assignments #
      ###############

      class Assignment < ActiveRecord::Base
        belongs_to :classroom
        belongs_to :teacher
        belongs_to :student
      end

      def create_assignment(attrs)
        assignment = Assignment.create(attrs)
        Tyto::Assignment.new( id:         assignment.id,
                              student_id: assignment.student_id,
                              chapter_id: assignment.chapter_id,
                              teacher_id: assignment.teacher_id,
                              classroom_id:     assignment.classroom_id,
                              assignment_size:  assignment.assignment_size )
      end

      def get_assignment(id)
        assignment = Assignment.find(id)
        Tyto::Assignment.new( id: assignment.id,
                              student_id:   assignment.student_id,
                              chapter_id:   assignment.chapter_id,
                              teacher_id:   assignment.teacher_id,
                              classroom_id: assignment.classroom_id,
                              assignment_size: assignment.assignment_size,
                              complete:     assignment.complete )
      end

      def edit_assignment(attrs)
        assignment = Assignment.find(attrs[:id])
        attrs.delete(:id)
        assignment.update(attrs)
        Tyto::Assignment.new( id: assignment.id,
                              student_id:   assignment.student_id,
                              chapter_id:   assignment.chapter_id,
                              teacher_id:   assignment.teacher_id,
                              classroom_id: assignment.classroom_id,
                              assignment_size: assignment.assignment_size,
                              complete:     assignment.complete )
      end

      def delete_assignment(id)
      end

      ############
      # Chapters #
      ############

      class Chapter < ActiveRecord::Base
        belongs_to :course
      end

      def create_chapter(attrs)
        chapter = Chapter.create(attrs)
        Tyto::Chapter.new(  id: chapter.id,
                            parent_id: chapter.parent_id,
                            name: chapter.name )
      end

      def get_chapter(id)
        chapter = Chapter.find(id)
        Tyto::Chapter.new(  id: chapter.id,
                            parent_id: chapter.parent_id,
                            name: chapter.name )
      end

      def edit_chapter(attrs)
      end

      def delete_chapter(id)
      end

      ###########
      # Classes #
      ###########

      class Classroom < ActiveRecord::Base
        belongs_to :teacher
        belongs_to :course
        has_many :assignments
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

      class Course < ActiveRecord::Base
        belongs_to :teacher
        has_many :chapters
      end

      def create_course(attrs)
      end

      def get_course(id)
      end

      def edit_course(attrs)
      end

      def delete_course(attrs)
      end

      ##############
      # Questions? #
      ##############

      class Question < ActiveRecord::Base
        belongs_to :chapter
        has_many :responses
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
        belongs_to :question
        belongs_to :student
        belongs_to :assignment
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
        belongs_to :student
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
        has_many :responses
        has_many :assignments
        belongs_to :classroom
      end

      def create_student(attrs)
        ar_student = Student.create(attrs)
        attrs[:id] = ar_student.id
        student = Tyto::Student.new(attrs)
      end

      def get_student(id)
        student = Student.find(id)
        student = Tyto::student.new(id: student.id, username: student.username, password: student.password, email: student.email, phone_number: student.phone_number)
      end

      def edit_student(attrs)
        student = Student.find(attrs[:id])
        attrs.delete(:id)
        student.update(attrs)
        new_student = Tyto::Student.new(id: student.id, username: student.username, password: student.password, email: student.email, phone_number: student.phone_number)
      end

      def delete_student(id)
        Student.destroy(id)
      end

      ####################
      # Teacher Sessions #
      ####################

      class TeacherSession < ActiveRecord::Base
        belongs_to :teacher
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
        has_many :assignments
        has_many :classrooms
      end

      def create_teacher(attrs)
        ar_teacher = Teacher.create(attrs)
        attrs[:id] = ar_teacher.id
        teacher = Tyto::Teacher.new(attrs)
      end

      def get_teacher(id)
        teacher = Teacher.find(id)
        new_teacher = Tyto::Teacher.new(id: teacher.id, username: teacher.username, password: teacher.password, email: teacher.email, phone_number: teacher.phone_number)
      end

      def edit_teacher(attrs)
        teacher = Teacher.find(attrs[:id])
        attrs.delete(:id)
        teacher.update(attrs)
        new_teacher = Tyto::Teacher.new(id: teacher.id, username: teacher.username, password: teacher.password, email: teacher.email, phone_number: teacher.phone_number)
      end

      def delete_teacher(id)
        Teacher.destroy(id)
      end
    end
  end
end
