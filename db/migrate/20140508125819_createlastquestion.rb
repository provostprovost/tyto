class Createlastquestion < ActiveRecord::Migration
  def change
    create_table :users_questions do |t|
      t.references :chapter
      t.references :student
      t.references :question
      t.references :assignment
      t.timestamps
    end
  end
end
