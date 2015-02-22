class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
  end

  def create
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
      if (user.froze)
        redirect_to :back, notice: "Your account is frozen please contact admin"
      else
        session[:user_id] = user.id
        redirect_to user_path(user), notice: "Welcome back!"
      end
    else
      redirect_to :back, notice: "username and password do not match"
    end
  end

  def destroy
    # nollataan sessio
    session[:user_id] = nil
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end
end