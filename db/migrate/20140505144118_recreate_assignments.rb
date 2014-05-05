class RecreateAssignments < ActiveRecord::Migration
  def change
    drop_table :assignments

    create_table :assignments do |t|
      t.references :student
      t.references :teacher
      t.references :chapter
      t.references :class
      t.boolean    :complete
      t.integer    :assignment_size
    end
  end
end
