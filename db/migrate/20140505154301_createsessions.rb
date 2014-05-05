class Createsessions < ActiveRecord::Migration
  def change
    create_table :teacher_sessions do |t|
      t.references :teacher
    end
  end
end
