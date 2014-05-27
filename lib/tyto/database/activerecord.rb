require "active_record"
require "yaml"
require 'bcrypt'
require 'pry-debugger'

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

      ###############
      # Assignments #
      ###############


      def get_assignments_for_classroom(classroom_id, student_id)
        assignments = Assignment.where(classroom_id: classroom_id, student_id: student_id).order(:deadline)
        return nil if assignments.last == nil
        assignments.map { |assignment| get_assignment(assignment.id) }
      end

      def get_assignments_for_student(student_id)
        assignments = Assignment.where(student_id: student_id).order(:deadline)
        return nil if assignments.last == nil
        assignments.map { |assignment| get_assignment(assignment.id) }
      end




      ###########
      # Invites #
      ###########


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

      ############
      # Chapters #
      ############



      def get_subtopics_from_course(course_id)
        subtopics = Chapter.where(course_id: course_id)
        subtopics = subtopics.select{|subtopic| subtopic.parent_id != nil}
        subtopics.map{|subtopic| get_chapter(subtopic.id)}
      end



      ##############
      # Classrooms #
      ##############







      def get_classrooms_for_teacher(teacher_id)
        classrooms = Teacher.find_by(id: teacher_id).classrooms
        classrooms.map { |classroom| get_classroom(classroom.id) }
      end

      def get_classroom_from_name(name)
        classroom = Classroom.find_by(:name => name)
        return nil if classroom == nil
        Tyto::Classroom.new(  id:         classroom.id,
                              course_id:  classroom.course_id,
                              teacher_id: classroom.teacher_id,
                              name: classroom.name )
      end

      ###########
      # Courses #
      ###########



      def get_course_from_name(name)
        course = Course.find_by(:name => name)
        return nil if course == nil
        course = Tyto::Course.new(id: course.id, name: course.name)
      end



      ############
      # Teachers #
      ############



      def get_past_messages(classroom_id, size)
        messages = Message.where(classroom_id: classroom_id).last(size)
        return [] if messages.last == nil
        messages.map{|message| get_message(message.id) }
      end

      ##############
      # Questions? #
      ##############



      def get_next_question(proficiency, student_id, chapter_id)
        questions = Question.where(chapter_id: chapter_id)
        return nil if questions.last == nil
        responses = Response.where(student_id: student_id, chapter_id: chapter_id)
        unanswered = []
        if responses != []
          questions.each do |x|
            answered = false
            responses.each do |y|
              answered=true if x.id==y.question_id
            end
            unanswered.push(x) if answered == false
          end
        else
          unanswered = questions
        end
          if proficiency < 0.4
            level = 1
          elsif proficiency < 0.7
            level = 2
          elsif proficiency < 0.9
            level = 3
          else
            level = 4
          end
          selected_questions = unanswered.select{|x| x.level == level}
          if selected_questions == []
            selected_questions = questions.select{|x| x.level == level}
          end
          index = rand(0...selected_questions.length)
          return get_question(selected_questions[index].id)
      end



      def get_last_question(attrs)
        last = UsersQuestions.find_by(attrs)
        return nil if last == nil
        question = get_question(last.question_id)
      end

      def update_last_question(attrs)
        last = UsersQuestions.find_by(student_id: attrs[:student_id], assignment_id: attrs[:assignment_id])
        if last == nil
          last = UsersQuestions.create(attrs)
          question = get_question(last.question_id)
        else
          last.question_id = attrs[:question_id]
          last.save
          question = get_question(last.question_id)
        end
      end

      #############
      # Responses #
      #############



      def get_responses_for_assignment(assignment_id)
        Response.where(assignment_id: assignment_id).order(:created_at)
      end

      def get_difficult_questions_for_chapter(chapter_id, classroom_id)
        students = get_students_in_classroom(classroom_id)
        difficult = {}
        students.each do |student|
          responses = Response.where(student_id: student.id, chapter_id: chapter_id, difficult: true)
          responses.each do |response|
            question = get_question(response.question_id)
            if difficult[question.question]
              difficult[question.question] += 1
            else
              difficult[question.question] = 1
            end
          end
        end
        difficult.to_a.sort_by{|element| element[1]}.reverse
      end

      ##############
      # Statistics #
      ##############

      def get_proficiency(response_id)
        response = get_response(response_id)
        student_id = response.student_id
        chapter_id = response.chapter_id
        assignment = get_assignment(response.assignment_id)
        responses = Response.where(student_id: student_id, chapter_id: chapter_id).order(:created_at).to_a

        responses.map! do |response|
          question = get_question(response.question_id)
          if response.correct
            question.level
          else
            -1 + 0.5 * (question.level - 1)
          end
        end

        score(responses, assignment.assignment_size)
      end

      def get_last_proficiency_score(student_id, chapter_id, actual=nil)
        responses = Response.where(student_id: student_id, chapter_id: chapter_id)
        return 0 if responses.last == nil
        response = responses.last(2)[0]
        response = responses.last if actual
        if response.proficiency
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

      def ema(array, alpha_n=1)
        alpha = alpha_n.to_f / array.count
        n = (1..array.count).to_a.map{|tidx| (1 - alpha) ** (tidx - 1) * array[array.count - tidx]}.sum
        d = (1..array.count).to_a.map{|tidx| (1 - alpha) ** (tidx -1)}.sum
        n / d
      end

      def score(array, assignment_size, alpha_n=1)
        multiplier = array.size / (assignment_size.to_f / 3)
        multiplier = 1 if multiplier > 1
        score = Math.log(ema(array, alpha_n)+1) * multiplier
        if score > 0
          return score
        else
          return 0
        end
      end

      ############
      # Sessions #
      ############



      ############
      # Students #
      ############


      def delete_student_from_classroom(student_id, classroom_id)
        ClassroomsUsers.where(:classroom_id => classroom_id, student_id: student_id).destroy_all
        Assignment.where(:classroom_id => classroom_id, student_id: student_id).destroy_all
      end



      def is_student_struggling(student_id, classroom_id)
        if classroom_id == nil
          assignments = Assignment.where(student_id: student_id, complete: true).last(5)
          return false if assignments.last == nil
          proficiencies = assignments.map{|assignment| get_assignment(assignment.id).proficiency}
          total_proficiency = 0.0
            proficiencies.each do |proficiency|
              total_proficiency += proficiency
            end
          average = total_proficiency / proficiencies.length
          return true if average < 0.6
          return false if average >= 0.6
        else
          assignments = Assignment.where(student_id: student_id, complete: true, classroom_id: classroom_id).last(5)
          return false if assignments.last == nil
          proficiencies = assignments.map{|assignment| get_assignment(assignment.id).proficiency}
          total_proficiency = 0.0
            proficiencies.each do |proficiency|
              total_proficiency += proficiency
            end
          average = total_proficiency / proficiencies.length
          return true if average < 0.6
          return false if average >= 0.6
        end
      end

      def is_student_to_be_texted(student_id, classroom_id)
        if classroom_id == nil
          return false
        else
          student = ClassroomsUsers.where(student_id: student_id, classroom_id: classroom_id).last
          return false if student.text == nil
          return true if student.text == true
          return false if student.text == false
        end
      end

      def get_classroom_students_to_be_texted(classroom_id)
        students = ClassroomsUsers.where(classroom_id: classroom_id, text: true)
        students.map {|x| get_student(x.student_id) }
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
