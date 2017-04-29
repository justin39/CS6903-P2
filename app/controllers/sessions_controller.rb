class SessionsController < ApplicationController
  before_filter :save_login_state, only: [:login, :login_attempt]

  def login
	# login form
  end

  def logout
	session[:user_id] = nil
	redirect_to action: 'login', notice: 'Sucessfully signed out'
  end

  def login_attempt
	authorized_user = User.authenticate(params[:username], params[:login_password])
	if authorized_user
	  reset_session
	  session[:user_id] = authorized_user.id
	  return redirect_to articles_path, notice: "Successfully logged in as #{authorized_user.username}"
	else
	  return redirect_to :back, alert: "Invalid username or password"
	end
  end
end
