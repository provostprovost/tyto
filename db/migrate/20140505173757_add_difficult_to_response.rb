class AddDifficultToResponse < ActiveRecord::Migration
  def change
    drop_table :responses

    create_table :responses do |t|
      t.references :question
      t.references :student
      t.references :assignment
      t.boolean :correct
      t.boolean :difficult
    end
  end
end
