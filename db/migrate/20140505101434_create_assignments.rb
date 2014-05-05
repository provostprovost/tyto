class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.references :student
      t.references :teacher
      t.references :chapter
      t.boolean    :complete
      t.integer    :assignment_size
    end
  end
end
