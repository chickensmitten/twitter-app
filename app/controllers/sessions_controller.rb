class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      flash[:notice] = "welcome, you're logged in!"
      redirect_to timeline_path
    else
      flash.now[:error] = "There is something wrong with your username or password." # flash says, show this message on the next redirect. flash.now as show it now.
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "you've logged out."
    redirect_to login_path
  end

end