class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references  :chapter
      t.string      :question
      t.string      :answer
      t.integer     :level
    end
  end
end
