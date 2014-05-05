class CreateClasses < ActiveRecord::Migration
  def change
    create_table :classes do |t|
      t.references  :teacher
      t.references  :chapter
    end
  end
end
