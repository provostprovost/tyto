class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.references :teacher
      t.references :student
      t.boolean :accepted
      t.references :classroom
      t.string :code
      t.timestamps
    end
  end
end
