class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.references :student
      t.references :chapter
      t.references :response
      t.integer :proficiency
      t.integer :current_streak
      t.integer :longest_streak
      t.timestamps
    end
  end
end
