class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :name

    end
  end
end
