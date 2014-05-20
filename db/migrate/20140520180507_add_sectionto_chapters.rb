class AddSectiontoChapters < ActiveRecord::Migration
  def change
    drop_table :chapters
    create_table :chapters do |t|
      t.string :name
      t.references :course
      t.string :subname
      t.integer :parent_id
      t.timestamps
    end
  end
end
