class AddColumnToUsersClassRooms < ActiveRecord::Migration
  def change
    drop_table :classrooms_users
    create_table :classrooms_users do |t|
      t.references :classroom
      t.references :student
      t.boolean :text
    end
  end
end
