class ChaptersController < ApplicationController
  def show
    render json: Tyto.db.get_chapter(params[:chapter_id])
  end
end
