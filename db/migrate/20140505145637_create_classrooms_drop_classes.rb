class CreateClassroomsDropClasses < ActiveRecord::Migration
  def change
    drop_table :classes

    create_table :classrooms do |t|
      t.references  :teacher
      t.references  :chapter
    end
  end
end
