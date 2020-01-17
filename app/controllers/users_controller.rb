class UsersController < ApplicationController

    get '/signup' do
      if !session[:user_id]
        erb :'users/new'
      else
        redirect to '/expenses'
      end
    end

    post '/signup' do
      if !params[:user].select{|k, v| v == ""}.empty?
        flash[:message] = "Please fill in all content"
        redirect to '/signup'
      else
        @user = User.new(params[:user]) # removed .create
        @user.save # added the save method, b/c I'm using .new
        session[:user_id] = @user.id
        redirect to '/expenses'
      end
    end
  
    get '/login' do
      # if !session[:user_id]
      #   erb :'users/login'
      if !logged_in?
        erb :'users/login'
      else
        redirect to '/expenses'
      end
    end
  
    post '/login' do
      @user = User.find_by(username: params[:username])
      # binding.pry
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to '/expenses'
      else
        flash[:message] = "Invalid username or password."
        erb :'users/login'
      end
    end
  
    get '/logout' do
      if logged_in?
        # @user = current_user
        # @user = nil
        session.destroy
        redirect to '/'
      else
        rediect to '/'
      end
    end
end