class SessionsController < ApplicationController
  def new
  end

  def create
    result = Tyto::SignIn.run(params)
    if result.success?
      cookies.permanent[:remember_token] = result.session_id
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
  end
end
