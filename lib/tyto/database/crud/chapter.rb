require "active_record"

module Tyto
  module Database
    class Persistence

      class Chapter < ActiveRecord::Base
        belongs_to :course
        has_many :questions
        has_many :chapters
      end

      def create_chapter(attrs)
        chapter = Chapter.create(attrs)
        Tyto::Chapter.new(  id: chapter.id,
                            parent_id: chapter.parent_id,
                            course_id: chapter.course_id,
                            name: chapter.name,
                            subname: chapter.subname,
                            video_url: chapter.video_url )
      end

      def get_chapter(id)
        chapter = Chapter.find_by(:id => id)
        return nil if chapter == nil
        Tyto::Chapter.new(  id: chapter.id,
                            parent_id: chapter.parent_id,
                            course_id: chapter.course_id,
                            name: chapter.name,
                            subname: chapter.subname,
                            video_url: chapter.video_url )
      end

      def edit_chapter(attrs)
        chapter = Chapter.find_by(id: attrs[:id])
        return nil if chapter == nil
        attrs.delete(:id)
        chapter.update(attrs)
        Tyto::Chapter.new(  id: chapter.id,
                            course_id: chapter.course_id,
                            parent_id: chapter.parent_id,
                            name: chapter.name,
                            subname: chapter.subname )
      end

      def delete_chapter(id)
        Chapter.destroy(id)
      end
    end
  end
end
