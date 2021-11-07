class SessionsController < ApplicationController
  def create
    session[:user_id] = params[:user_id]
  end

  def destroy
    session[:user_id] = nil
  end
end
