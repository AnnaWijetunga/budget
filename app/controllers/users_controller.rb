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
        @user = User.create(params[:user])
        session[:user_id] = @user.id # logs user in
        redirect to '/expenses'
      end
    end
  
    get '/login' do
      if !logged_in?
        erb :'users/login'
      else
        redirect to '/expenses'
      end
    end
  
    post '/login' do
      @user = User.find_by(username: params[:user][:username])
      if @user && @user.authenticate(params[:user][:password]) # validates password match
        session[:user_id] = @user.id # logs user in
        redirect to '/expenses'
      else
        flash[:message] = "Invalid username or password."
        erb :'users/login'
      end
    end
  
    get '/logout' do
      if logged_in?
        session.destroy
        redirect to '/'
      else
        rediect to '/'
      end
    end
end