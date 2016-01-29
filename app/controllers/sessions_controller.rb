class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the users's show page
      log_in user
      redirect_to user
    else
      # Create error message
      flash.now[:errors] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  end
end