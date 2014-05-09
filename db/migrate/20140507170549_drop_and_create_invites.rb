class DropAndCreateInvites < ActiveRecord::Migration
  def change

    create_table :invites do |t|
      t.references :teacher
      t.string :email
      t.boolean :accepted
      t.references :classroom
      t.string :code
      t.timestamps
    end
  end
end
