class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :question
      t.references :student
      t.references :assignment
      t.boolean :correct
    end
  end
end
