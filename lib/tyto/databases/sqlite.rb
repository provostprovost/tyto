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

      def clear_everything
        Assignment.delete_all
        Chapter.delete_all
        Classroom.delete_all
        ClassroomsUsers.delete_all
        Course.delete_all
        Question.delete_all
        Response.delete_all
        Session.delete_all
        Student.delete_all
        Teacher.delete_all
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
        Assignment.destroy(id)
      end

      ############
      # Chapters #
      ############

      class Chapter < ActiveRecord::Base
        belongs_to :course
        has_many :statistics
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
        chapter = Chapter.find(attrs[:id])
        attrs.delete(:id)
        chapter.update(attrs)
        Tyto::Chapter.new(  id: chapter.id,
                            parent_id: chapter.parent_id,
                            name: chapter.name )
      end

      def delete_chapter(id)
        Chapter.destroy(id)
      end

      ##############
      # Classrooms #
      ##############

      class Classroom < ActiveRecord::Base
        belongs_to :teacher
        belongs_to :course
        has_many :assignments
      end

      def create_classroom(attrs)
        classroom = Classroom.create(attrs)
        Tyto::Classroom.new(  id:         classroom.id,
                              course_id:  classroom.course_id,
                              teacher_id: classroom.teacher_id )
      end

      def get_classroom(id)
        classroom = Classroom.find(id)
        Tyto::Classroom.new(  id:         classroom.id,
                              course_id:  classroom.course_id,
                              teacher_id: classroom.teacher_id )
      end

      def edit_classroom(attrs)
      end

      def delete_classroom(id)
        Classroom.destroy(id)
      end

      class ClassroomsUsers < ActiveRecord::Base
        belongs_to :student
        belongs_to :classroom
      end

      def add_student_to_classroom(attrs)
        pair = ClassroomsUsers.create(attrs)
      end

      def get_students_in_classroom(id)
        students = ClassroomsUsers.where(classroom_id: id)
        students.map do |pair|
          get_student(pair.student_id)
        end
      end

      ###########
      # Courses #
      ###########

      class Course < ActiveRecord::Base
        belongs_to :teacher
        has_many :chapters
      end

      def create_course(attrs)
        ar_course = Course.create(attrs)
        attrs[:id] = ar_course.id
        course = Tyto::Course.new(attrs)
      end

      def get_course(id)
        course = Course.find(id)
        course = Tyto::Course.new(name: course.name)
      end

      def edit_course(attrs)
        course = Course.find(attrs[:id])
        attrs.delete(:id)
        course.update(attrs)
        course = Tyto::Course.new(id: course.id, name: course.name)
      end

      def delete_course(id)
        Course.destroy(id)
      end

      ##############
      # Questions? #
      ##############

      class Question < ActiveRecord::Base
        belongs_to :chapter
        has_many :responses
      end

      def create_question(attrs)
        ar_question = Question.create(attrs)
        attrs[:id] = ar_question.id
        question = Tyto::Question.new(attrs)
      end

      def get_question(id)
        question = Question.find(id)
        new_question = Tyto::Question.new(question: question.question, id: question.id, level: question.level, answer: question.answer, chapter_id: question.chapter_id)
      end

      def edit_question(attrs)
        question = Question.find(attrs[:id])
        attrs.delete(:id)
        question.update(attrs)
        question = Tyto::Question.new(id: question.id, level: question.level, answer: question.answer, chapter_id: question.chapter_id)
      end

      def delete_question(id)
        Question.destroy(id)
      end

      #############
      # Responses #
      #############

      class Response < ActiveRecord::Base
        belongs_to :question
        belongs_to :student
        belongs_to :assignment
        has_one :statistics
      end

      def create_response(attrs)
        ar_response = Response.create(attrs)
        attrs[:id] = ar_response.id
        response = Tyto::Response.new(attrs)
      end

      def get_response(id)
        response = Response.find(id)
        new_response = Tyto::Response.new(id: response.id, correct: response.correct, question_id: response.question_id, student_id: response.student_id, assignment_id: response.assignment_id, difficult: response.difficult)
      end

      ##############
      # Statistics #
      ##############

      class Statistic < ActiveRecord::Base
        belongs_to :student
        belongs_to :chapter
        belongs_to :response
      end

      def get_proficiency(response_id)
        response = get_response(response_id)
        student_id = response.student_id
        assignment_id = response.assignment_id
        assignment = get_assignment(assignment_id)
        chapter_id = assignment.chapter_id
        question = get_question(response.question_id)
        last_proficiency_score = get_last_proficiency_score(student_id, chapter_id)

        if response.correct
          last_proficiency_score += 6 / question.level
        else
          last_proficiency_score -= 6 / question.level
        end

        last_profiency_score
      end

      def get_last_proficiency_score(student_id, chapter_id)
        statistic = Statistics.where(student_id: student_id, chapter_id: chapter_id).last
        if statistic.proficiency
          return statistic.proficiency
        else
          return 0
        end
      end

      ####################
      # Student Sessions #
      ####################

      class Session < ActiveRecord::Base
        belongs_to :student
        belongs_to :teacher
      end

      def create_student_session(attrs)
        ar_session = Session.create(attrs)
        session = Tyto::Session.new(id: ar_session.id, student_id: ar_session.student_id)
      end

      def get_student_session(id)
        ar_session = Session.find(id)
        session = Tyto::Session.new(id: ar_session.id, student_id: ar_session.student_id)
      end

      def delete_student_session(id)
        Session.destroy(id)
      end

      ####################
      # Teacher Sessions #
      ####################

      def create_teacher_session(attrs)
        ar_session = Session.create(attrs)
        session = Tyto::Session.new(id: ar_session.id, teacher_id: ar_session.teacher_id)
      end

      def get_teacher_session(id)
        ar_session = Session.find(id)
        session = Tyto::Session.new(id: ar_session.id, teacher_id: ar_session.teacher_id)
      end

      def delete_teacher_session(id)
        Session.destroy(id)
      end

      ############
      # Students #
      ############

      class Student < ActiveRecord::Base
        has_many :responses
        has_many :assignments
        has_many :statistics
        belongs_to :classroom
      end

      def create_student(attrs)
        ar_student = Student.create(attrs)
        attrs[:id] = ar_student.id
        student = Tyto::Student.new(attrs)
      end

      def get_student(id)
        student = Student.find(id)
        student = Tyto::Student.new(id: student.id, username: student.username, password: student.password, email: student.email, phone_number: student.phone_number)
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
