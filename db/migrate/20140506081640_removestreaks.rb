class Removestreaks < ActiveRecord::Migration
  def change
    drop_table :statistics
    create_table :statistics do |t|
      t.references :student
      t.references :chapter
      t.references :response
      t.integer :proficiency
      t.timestamps
    end
  end
end
