require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "so_secure"
  end

  get "/" do
    if logged_in?
      redirect to('/expenses')
    else
      erb :welcome
    end
  end

  helpers do

    def current_user
      @current_user ||= User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

  end

  # helpers do

  #   def logged_in?
  #     !!current_user
  #   end

  #   def current_user
  #     @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  #   end

  # end
end
