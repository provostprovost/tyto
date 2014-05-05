class EditSessions < ActiveRecord::Migration
  def change
    drop_table :teacher_sessions
    drop_table :student_sessions
    create_table :sessions do |t|
      t.references :student
      t.references :teacher
    end
  end
end
