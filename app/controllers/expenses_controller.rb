class ExpensesController < ApplicationController

    get '/expenses' do
      if logged_in?
        @expenses = current_user.expenses
        erb :'expenses/index'
      else
        redirect to '/login'
      end
    end
  
    get '/expenses/new' do
      if logged_in?
        erb :'expenses/new'
      else
        redirect to '/login'
      end
    end
  
    post '/expenses' do
      if logged_in?
        @expense = current_user.expenses.build(params).save
        if params[:vendor].empty? ||params[:description].empty? || params[:date].empty? || params[:total].empty?
          flash[:message] = "Please fill all boxes, thank you!"
          redirect to "/expenses/new"
        else
          redirect to('/expenses')
        end
      else
        redirect to('/login')
      end
    end
  
    # shows one expense
    get '/expenses/:id' do
      @expense = Expense.find(params[:id])
      if logged_in? && @expense.user == current_user
        erb :'expenses/show'
      else
        redirect to('/login')
      end
    end
  
    # if logged in, user sees edit form
    # user can only edit expenses they created
    get '/expenses/:id/edit' do
      @expense = Expense.find(params[:id])
      if logged_in? && @expense.user == current_user
        @expense = Expense.find(params[:id])
        @user = User.find(session[:user_id])
        erb :'expenses/edit'
      else
        redirect to('/login')
      end
    end
  
    patch '/expenses/:id' do
      @expense = Expense.find(params[:id])
      @expense.vendor = params[:vendor]
      @expense.description = params[:description]
      @expense.date = params[:date]
      @expense.total = params[:total]
      if !@expense.save
        @errors = @expense.errors.full_messages
        erb :'/expenses/edit'
      else
        redirect to("/expenses/#{@expense.id}")
      end
    end
  
    delete '/expenses/:id/delete' do
      @expense = Expense.find(params[:id])
      if logged_in? && @expense.user == current_user
        @expense.destroy
        redirect to('/expenses')
      else
        redirect to('/login')
      end
    end 
end