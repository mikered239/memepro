class UsersController < ApplicationController
before_filter :authenticate, :except => [:new ]

  def new
    @user = User.new
  end


  def index
    @user = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You have succesfully subscribed!"
      redirect_to :back
    else
      flash[:danger] = 'Please enter a 10 digit number'
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_url

  end

  private

    def user_params
      params.require(:user).permit(:name, :number)
    end

end
