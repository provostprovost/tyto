class Adddeadlinetoassignments < ActiveRecord::Migration
  def change
    drop_table :assignments
    create_table :assignments do |t|
      t.references :student
      t.references :teacher
      t.references :chapter
      t.references :classroom
      t.boolean    :complete
      t.integer    :assignment_size
      t.datetime   :deadline
      t.timestamps
    end
  end
end
