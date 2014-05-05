class CreateClassesStudents < ActiveRecord::Migration
  def change
    create_table :classes_users do |t|
      t.references :class
      t.references :user
    end
  end
end
