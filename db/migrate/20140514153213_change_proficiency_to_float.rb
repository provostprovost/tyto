class ChangeProficiencyToFloat < ActiveRecord::Migration
  def change
    drop_table :responses

    create_table :responses do |t|
      t.references :question
      t.references :student
      t.references :assignment
      t.references :chapter
      t.boolean    :correct
      t.boolean    :difficult
      t.float    :proficiency
      t.string     :answer
    end
    add_column(:responses, :created_at, :datetime)
    add_column(:responses, :updated_at, :datetime)
  end
end
