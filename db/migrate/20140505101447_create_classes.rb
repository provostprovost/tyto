class CreateClasses < ActiveRecord::Migration
  def change
    create_table :classes do |t|
      t.references  :teacher
    end
  end
end
