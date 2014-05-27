require "active_record"

module Tyto
  module Database
    class Persistence
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
        course = Tyto::Course.new(name: course.name, id: course.id)
      end

      def get_all_courses
        courses = Course.all
        courses.map {|course| get_course(course.id)}
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
    end
  end
end
