class AddCourseIdToChapter < ActiveRecord::Migration
  def change
    add_column(:chapters, :course_id, :integer)
  end
end
