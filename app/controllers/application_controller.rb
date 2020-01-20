require './config/environment'
require 'rack-flash'

# A Sinatra Controller is a Ruby Class that inherits from Sinatra::Base 
# This inheritance transforms our Ruby class into a web app 
# by giving it a Rack-compatible interface through inheriting from the "base" of the Sinatra framework

class ApplicationController < Sinatra::Base

  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions # turns sessions on 
    set :session_secret, "so_secure" # encryption key used to create a session_id
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
      !!session[:user_id] # will return true unless the value of session[:user_id] is false or nil.
    end

  end

end
