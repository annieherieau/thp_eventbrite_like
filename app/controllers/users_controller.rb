class UsersController < ApplicationController
  before_action :authenticate_user, except: [:new, :create]

  def show
    @user = User.find(params['id'])
    @admin_events = Event.where(admin_user_id: @user.id)
    @user.admin_events
    @events = @user.events
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      first_name: params['first_name'],
      last_name: params['last_name'],
      email: params['email'],
      email_confirmation: params['email_confirmation'],
      password: params['password'],
      input_pwd: params['password'],
      password_confirmation: params['password_confirmation'],
      description: params['description']
    )

    if @user.save
      log_in(@user)
      remember(@user) unless params['remember_check'].to_i.zero?
      redirect_to root_path
    else
      render :new
    end
  end


  def edit

  end

  def destroy
  end

  private
  def post_params
    post_params = params.require(:user).permit(:first_name, :last_name, :email, :description, :password)
  end
end
