class ChangeChapterColumnName < ActiveRecord::Migration
  def change
    rename_column :chapters, :chapter_id, :parent_id
  end
end
