class SessionsController < ApplicationController
  def new
  end

  def create
    result = Tyto::SignIn.run(params)
    if result.success?
      if params[:teacher]
        redirect_to "/teachers/#{result.user.id}"
      else
        redirect_to "/students/#{result.user.id}"
      end
    else
      flash.now[:error] =
      render 'new'
    end
  end

  def delete
  end
end
