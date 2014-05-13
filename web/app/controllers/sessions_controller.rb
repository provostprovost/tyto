class SessionsController < ApplicationController
  def new
    if session[:app_session_id]
      existing_session = Tyto.db.get_session(session[:app_session_id])
      if existing_session.student_id
        redirect_to "/students/#{existing_session.student_id}"
      elsif existing_session.teacher_id
        redirect_to "/teachers/#{existing_session.teacher_id}"
      else
        redirect_to root_url
      end
    end
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

  def destroy
    Tyto.db.delete_session(session[:app_session_id])
    session[:app_session_id] = nil
    redirect_to root_url
  end
end
