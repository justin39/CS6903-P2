class UsersController < ApplicationController
  before_action :set_user, except: [:index, :create, :new]
  before_filter :save_login_state, only: [:new, :create]

  def index
	@users = User.all
  end

  def new
	@user = User.new
  end

  def create
	@user = User.new(user_params)
	if @user.save
	  flash[:notice] = "You signed up successfully"
	  return redirect_to root_path
	else
	  flash[:notice] = "Unable to sign up"
	end
	render "new"
  end

  def update
	if @user.update_attributes(user_params)
	  redirect_to @user, notice: 'Account was successfully updated'
	else
	  render :edit
	end
  end
  
  def destroy
    if @user.destroy
      redirect_to users_path, alert: 'User account was successfully deleted'
    else
      render :edit, alert: 'User account could not be deleted'
    end
  end

  def show
  end
  
  def edit
  end

  private

  	def set_user
	  @user = User.find(params[:id])
	end

	def user_params
	  params.require(:user).permit(:username, :password, :password_confirmation)
	end
end
