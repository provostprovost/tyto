class DropClassesUsersAddClassroomsUsers < ActiveRecord::Migration
  def change
    drop_table :classes_users

    create_table :classrooms_users do |t|
      t.references :classroom
      t.references :student
    end
  end
end
