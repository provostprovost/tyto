class AddVideoUrlToChapter < ActiveRecord::Migration
  def change
    add_column(:chapters, :video_url, :text)
  end
end
