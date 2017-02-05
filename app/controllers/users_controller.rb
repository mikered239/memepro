class UsersController < ApplicationController
before_filter :authenticate, :except => [:new ]

  def load_twilio
    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new TWILIO_ACC_SID, TWILIO_AUTH_TOKEN
  end

  def first_time(user)
    load_twilio

    @name = user.name
    @phone_number = user.number
    message = "Hey #@name, thanks for signing up for dank memes. You are now going to recieve memes everyday at 4:20pm "
    @message = @client.account.messages.create(
                                              from: '+19147684531',
                                              to: @phone_number,
                                              body: message
                                              )
   puts "Sent sign up message to #@name"
  end

  def delete_user(user)
    load_twilio

    @name = user.name
    @phone_number = user.number
    message = "Hey #@name, you have now been unsubscribed from memes daily. "
    @message = @client.account.messages.create(
                                              from: '+19147684531',
                                              to: @phone_number,
                                              body: message
                                              )
   puts "Sent delete message to #@name"
  end

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
      first_time(@user)
      redirect_to :back
    else
      flash[:danger] = 'Please enter a 10 digit number'
      render 'new'
    end
  end

  def destroy
    deleteUser = User.find(params[:id])
    delete_user(deleteUser)
    deleteUser.destroy
    flash[:success] = "User deleted"
    redirect_to root_url

  end

  private

    def user_params
      params.require(:user).permit(:name, :number)
    end

end
