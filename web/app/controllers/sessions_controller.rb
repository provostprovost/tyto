class SessionsController < ApplicationController
  def new
  end

  def create
    result = Tyto::SignIn.run(params)
    if result.success?
      session[:app_session_id] = result.session_id
      if params[:teacher]
        redirect_to "/teachers/#{result.user.id}"
      else
        redirect_to "/students/#{result.user.id}"
      end
    else
      flash.now[:error] = result.error
      render 'new'
    end
  end

  def delete
    Tyto.db.delete_session(session[:app_session_id])
    redirect_to root_url
  end
end
