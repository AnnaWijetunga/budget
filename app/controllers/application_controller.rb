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

    def authorize_user(expense)
      if expense.user == current_user
        erb :'expenses/edit'
      else
        redirect to '/expenses'
      end
    end
    
  end

end

# Rendering a file displays that view without submitting 
# an additional request to the server. It also allows us 
# to pass instance variables through to the erb file that 
# can be used to change the specifics of what the page will display.

# A redirect differs from a render in that it sends a new 
# call request to the server. 
# We can not pass instance variables through a redirect, 
# as those variables no longer exist once a new request has 
# been made, due to the statelessness of the server.
# login route is an example