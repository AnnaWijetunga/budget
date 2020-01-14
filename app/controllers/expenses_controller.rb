class ExpensesController < ApplicationController

    get '/expenses' do
      if logged_in?
        @expenses = current_user.expenses
        erb :'expenses/index'
      else
        redirect to('/login')
      end
    end
  
    get '/expenses/new' do
      if logged_in?
        erb :'expenses/create_expense'
      else
        redirect to('/login')
      end
    end
  
    post '/expenses' do
      if logged_in?
        @expense = current_user.expenses.build(params)
        if params[:vendor].empty? ||params[:date].empty? || params[:total].empty? || params[:description].empty?
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
        erb :'expenses/show_expense'
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
        erb :'expenses/update_expense'
      else
        redirect to('/login')
      end
    end
  
    # user must edit without leaving any blank content
    patch '/expenses/:id' do
      if !params[:vendor].empty? && !params[:date].empty? && !params[:total].empty? && !params[:description].empty?
        @expense = Expense.find(params[:id])
        @expense.update(vendor:params[:vendor], date:params[:date], total:params[:total], description:params[:description])
        @expense.save
        flash[:message] = "Your expense has been updated!"
        redirect to "/expenses"
      else
        flash[:message] = "Please fill all boxes, thank you!"
        redirect to "/expenses/#{params[:id]}/edit"
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