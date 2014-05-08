require "active_record"
require "yaml"
# require 'pry-debugger'
require 'bcrypt'

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
        assignment = Assignment.find_by(:id => id)
        return nil if assignment == nil
        Tyto::Assignment.new( id: assignment.id,
                              student_id:   assignment.student_id,
                              chapter_id:   assignment.chapter_id,
                              teacher_id:   assignment.teacher_id,
                              classroom_id: assignment.classroom_id,
                              assignment_size: assignment.assignment_size,
                              complete:     assignment.complete )
      end

      def edit_assignment(attrs)
        assignment = Assignment.find_by(:id => attrs[:id])
        return nil if assignment == nil
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

      ###############
      # Invites #
      ###############

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
                          code:         invite.code,
                          accepted:     invite.accepted
                              )
      end

      def get_invite(id)
        invite = Invite.find_by(:id => id)
        return nil if invite == nil
        Tyto::Invite.new(id:           invite.id,
                         email:        invite.email,
                         teacher_id:   invite.teacher_id,
                         classroom_id: invite.classroom_id,
                         code:         invite.code,
                         accepted:     invite.accepted)
      end

      def accept_invite(id)
        invite = Invite.find_by(:id => id)
        return nil if invite == nil
        invite.accepted = true
        Tyto::Invite.new(id:           invite.id,
                         email:        invite.email,
                         teacher_id:   invite.teacher_id,
                         classroom_id: invite.classroom_id,
                         code:         invite.code,
                         accepted:     invite.accepted)

      end

      def delete_invite(id)
        Invite.destroy(id)
      end


      ############
      # Chapters #
      ############

      class Chapter < ActiveRecord::Base
        belongs_to :course
        has_many :questions
      end

      def create_chapter(attrs)
        chapter = Chapter.create(attrs)
        Tyto::Chapter.new(  id: chapter.id,
                            parent_id: chapter.parent_id,
                            name: chapter.name )
      end

      def get_chapter(id)
        chapter = Chapter.find_by(:id => id)
        return nil if chapter == nil
        Tyto::Chapter.new(  id: chapter.id,
                            parent_id: chapter.parent_id,
                            name: chapter.name )
      end

      def edit_chapter(attrs)
        chapter = Chapter.find_by(id: attrs[:id])
        return nil if chapter == nil
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
        has_many :invites
        has_many :assignments
      end

      def create_classroom(attrs)
        classroom = Classroom.create(attrs)
        Tyto::Classroom.new(  id:         classroom.id,
                              course_id:  classroom.course_id,
                              teacher_id: classroom.teacher_id,
                              name: classroom.name )
      end

      def get_classroom(id)
        classroom = Classroom.find_by(id: id)
        return nil if classroom == nil
        Tyto::Classroom.new(  id:         classroom.id,
                              course_id:  classroom.course_id,
                              teacher_id: classroom.teacher_id,
                              name: classroom.name )
      end

      def edit_classroom(attrs)
      end

      def get_students_in_class(classroom_id)
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
        return nil if students.last == nil
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
        course = Course.find_by(id: id)
        return nil if course == nil
        course = Tyto::Course.new(name: course.name)
      end

      def get_course_from_name(name)
        course = Course.find_by(:name => name)
        return nil if course == nil
        course = Tyto::Course.new(id: course.id, name: course.name)
      end

      def edit_course(attrs)
        course = Course.find_by(id: attrs[:id])
        return nil if course == nil
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
        question = Question.find_by(id: id)
        return nil if question == nil
        new_question = Tyto::Question.new(question: question.question,
                                          id: question.id,
                                          level: question.level,
                                          answer: question.answer,
                                          chapter_id: question.chapter_id)
      end

      def edit_question(attrs)
        question = Question.find_by(id: attrs[:id])
        return nil if question == nil
        attrs.delete(:id)
        question.update(attrs)
        question = Tyto::Question.new(id: question.id,
                                      level: question.level,
                                      answer: question.answer,
                                      chapter_id: question.chapter_id)
      end

      def delete_question(id)
        Question.destroy(id)
      end

      def get_next_question(proficiency, student_id, chapter_id)
        ##SHORTEN THIS METHOD ##
        questions = Question.where(chapter_id: chapter_id)
        return nil if questions.last == nil
        responses = Response.where(student_id: student_id, chapter_id: chapter_id)
        return nil if responses.last == nil
        unanswered = []
        questions.each do |x|
          answered = false
          responses.each do |y|
            answered=true if x.id==y.question_id
          end
          unanswered.push(x) if answered == false
        end
          if proficiency < 40
            level = 1
          elsif proficiency < 60
            level = 2
          elsif proficiency < 80
            level = 3
          else
            level = 4
          end
          questions = unanswered.select{|x| x.level == level}
          if questions == []
            return nil
          end
          index = rand(0...questions.length)
          return get_question(questions[index].id)
      end


      #############
      # Responses #
      #############

      class Response < ActiveRecord::Base
        belongs_to :question
        belongs_to :student
        belongs_to :assignment
        belongs_to :chapter
      end

      def create_response(attrs)
        ar_response = Response.create(attrs)
        attrs[:id] = ar_response.id
        attrs[:proficiency] = get_proficiency(ar_response.id)
        ar_response.proficiency = attrs[:proficiency]
        ar_response.save
        response = Tyto::Response.new(attrs)
      end

      def get_response(id)
        response = Response.find_by(id: id)
        return nil if response == nil
        new_response = Tyto::Response.new(id: response.id,
                                          correct: response.correct,
                                          question_id: response.question_id,
                                          chapter_id: response.chapter_id,
                                          student_id: response.student_id,
                                          assignment_id: response.assignment_id,
                                          difficult: response.difficult,
                                          proficiency: response.proficiency )
      end

      def get_responses_for_assignment(assignment_id)
        Response.where(assignment_id: assignment_id)
      end

      ##############
      # Statistics #
      ##############

      def get_proficiency(response_id)
        response = get_response(response_id)
        student_id = response.student_id
        assignment_id = response.assignment_id
        assignment = get_assignment(assignment_id)
        chapter_id = assignment.chapter_id
        question = get_question(response.question_id)
        proficiency_score = get_last_proficiency_score(student_id, chapter_id)
        if response.correct
          proficiency_score += ( 12 / question.level )
        else
          proficiency_score -= ( 6 / question.level )
        end

        proficiency_score
      end

      def get_last_proficiency_score(student_id, chapter_id)
        response = Response.where(student_id: student_id, chapter_id: chapter_id)
        return 0 if response.last == nil
        response = response.last(2)[0]
        if response.proficiency != nil
          return response.proficiency
        else
          return 0
        end
      end

      def get_longest_streak(student_id, chapter_id)
        responses = Response.where(student_id: student_id, chapter_id: chapter_id).order(:created_at)

        counter = 0
        current_response = responses.where(correct: true).last
        longest_streak = 0
        streak = 0
        until counter == responses.length
          streak += 1 if responses[counter].correct == true
          streak = 0 if responses[counter].correct == false
          longest_streak = streak if streak > longest_streak
          counter += 1
        end
        return longest_streak
      end

      def current_chapter_streak(student_id, chapter_id)
        responses = Response.where(student_id: student_id, chapter_id: chapter_id).order(:created_at)
        streak = 0
        counter = responses.size - 1
        while counter >= 0
          break if !responses[counter].correct
          counter -= 1
          streak += 1
        end
        streak
      end

      ############
      # Sessions #
      ############

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
        Session.destroy(id)
      end

      ############
      # Students #
      ############

      class Student < ActiveRecord::Base
        has_many :responses
        has_many :assignments
        has_many :invites
        belongs_to :classroom
        include BCrypt
      end

      def create_student(attrs)
        attrs[:password_digest] = BCrypt::Password.create(attrs.delete(:password))

        student = Tyto::Student.new(attrs)
        ar_student = Student.create(username: student.username,
                                    password_digest: student.password_digest,
                                    email: student.email,
                                    phone_number: student.phone_number)
        student.id = ar_student.id
        student
      end

      def get_student(id)
        student = Student.find_by(id: id)
        return nil if student == nil
        retrieved = Tyto::Student.new( id: student.id,
                                      username: student.username,
                                      password: "temp",
                                      email: student.email,
                                      phone_number: student.phone_number)
        retrieved.password_digest = BCrypt::Password.new(student.password_digest)
        retrieved
      end

      def edit_student(attrs)
        student = Student.find_by(id: attrs[:id])
        return nil if student == nil
        attrs.delete(:id)
        attrs.delete(:password_digest)
        student.update(attrs)
        new_student = Tyto::Student.new(id: student.id,
                                        username: student.username,
                                        password_digest: student.password_digest,
                                        email: student.email,
                                        phone_number: student.phone_number)
      end

      def delete_student(id)
        Student.destroy(id)
      end

      def get_student_from_email(email)
        student = Student.find_by(email: email)
        return nil if student.nil?
        retrieved = Tyto::Student.new( id: student.id,
                                      username: student.username,
                                      password: "temp",
                                      email: student.email,
                                      phone_number: student.phone_number)
        retrieved.password_digest = BCrypt::Password.new(student.password_digest)
        retrieved
      end

      def get_student_from_email(email)
        student = Student.find_by(email: email)
        return nil if student.nil?
        retrieved = Tyto::Student.new( id: student.id,
                                      username: student.username,
                                      password: "temp",
                                      email: student.email,
                                      phone_number: student.phone_number)
        retrieved.password_digest = BCrypt::Password.new(student.password_digest)
        retrieved
      end

      def get_student_from_phone_number(phone_number)
        student = Student.find_by(phone_number: phone_number)
        return nil if student.nil?
        retrieved = Tyto::Student.new( id: student.id,
                                      username: student.username,
                                      password: "temp",
                                      email: student.email,
                                      phone_number: student.phone_number)
        retrieved.password_digest = BCrypt::Password.new(student.password_digest)
        retrieved
      end

      ############
      # Teachers #
      ############

      class Teacher < ActiveRecord::Base
        has_many :assignments
        has_many :classrooms
        has_many :invites
        include BCrypt
      end

      def create_teacher(attrs)
        attrs[:password_digest] = BCrypt::Password.create(attrs.delete(:password))

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
        attrs.delete(:password_digest)
        teacher.update(attrs)
        new_teacher = Tyto::Teacher.new(id: teacher.id,
                                        username: teacher.username,
                                        password_digest: teacher.password_digest,
                                        email: teacher.email,
                                        phone_number: teacher.phone_number)
      end

      def delete_teacher(id)
        Teacher.destroy(id)
      end

      def get_teacher_from_email(email)
        teacher = Teacher.find_by(email: email)
        return nil if teacher.nil?
        retrieved = Tyto::Teacher.new( id: teacher.id,
                                      username: teacher.username,
                                      password: "temp",
                                      email: teacher.email,
                                      phone_number: teacher.phone_number)
        retrieved.password_digest = BCrypt::Password.new(teacher.password_digest)
        retrieved
      end

      def get_teacher_from_phone_number(phone_number)
        teacher = Teacher.find_by(phone_number: phone_number)
        return nil if teacher.nil?
        retrieved = Tyto::Teacher.new( id: teacher.id,
                                      username: teacher.username,
                                      password: "temp",
                                      email: teacher.email,
                                      phone_number: teacher.phone_number)
        retrieved.password_digest = BCrypt::Password.new(teacher.password_digest)
        retrieved
      end
    end
  end
end
