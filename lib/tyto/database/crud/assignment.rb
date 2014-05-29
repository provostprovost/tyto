require "active_record"

module Tyto
  module Database
    class Persistence

      class Assignment < ActiveRecord::Base
        belongs_to :classroom
        belongs_to :teacher
        belongs_to :student
      end

      def create_assignment(attrs)
        attrs[:complete] = false if attrs[:complete] == nil
        assignment = Assignment.create(attrs)
        Tyto::Assignment.new( id:         assignment.id,
                              student_id: assignment.student_id,
                              chapter_id: assignment.chapter_id,
                              teacher_id: assignment.teacher_id,
                              classroom_id:     assignment.classroom_id,
                              assignment_size:  assignment.assignment_size,
                              complete: assignment.complete )
      end

      def get_assignment(id)
        assignment = Assignment.find_by(:id => id)
        return nil if assignment == nil
        current_question = get_last_question(student_id: assignment.student_id, assignment_id: assignment.id)
        question_text = current_question.question unless current_question.nil?
        question_level = current_question.level unless current_question.nil?
        chapter = get_chapter(assignment.chapter_id)
        course = get_course(chapter.course_id)
        course_name = course.name if course
        deadline = assignment.deadline
        Tyto::Assignment.new( id: assignment.id,
                              student_id:   assignment.student_id,
                              chapter_id:   assignment.chapter_id,
                              teacher_id:   assignment.teacher_id,
                              classroom_id: assignment.classroom_id,
                              course_name:  course_name,
                              assignment_size: assignment.assignment_size,
                              complete:     assignment.complete,
                              name:         get_chapter(assignment.chapter_id).name,
                              questions_answered: get_responses_for_assignment(assignment.id).count,
                              current_streak: current_chapter_streak(assignment.student_id, assignment.chapter_id),
                              longest_streak: get_longest_streak(assignment.student_id, assignment.chapter_id),
                              current_question_text: question_text,
                              proficiency: get_last_proficiency_score(assignment.student_id, assignment.chapter_id, true),
                              question_level: question_level,
                              proficiencies: get_responses_for_assignment(id).map { |response| response.proficiency},
                              deadline: deadline,
                              subname: chapter.subname,
                              video_url: chapter.video_url)
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
    end
  end
end
