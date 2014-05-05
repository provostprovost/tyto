class ClassroomChangeChapterToCourse < ActiveRecord::Migration
  def change
    drop_table :classrooms

    create_table :classrooms do |t|
      t.references :teacher
      t.references :course
    end
  end
end
