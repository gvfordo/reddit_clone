class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(session_params)
    if @user
      login!
      redirect_to user_url(@user)
    else
      flash[:errors] = ["Invalid username / password combination"]
      redirect_to new_session_url
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:user).permit(:user, :password)
  end
end
