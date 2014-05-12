class AddProficiencyToResponse < ActiveRecord::Migration
  def change
    drop_table :responses

    create_table :responses do |t|
      t.references :question
      t.references :student
      t.references :assignment
      t.references :chapter
      t.boolean    :correct
      t.boolean    :difficult
      t.integer    :proficiency
      t.string     :answer
    end
  end
end
