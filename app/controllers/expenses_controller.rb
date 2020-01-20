class ExpensesController < ApplicationController

    # instead of "if logged in", authenticate here
    set(:auth) do |auth_required|
      condition do
        if auth_required && !logged_in? 
          redirect "/login", 302
        end
      end
    end
  
    # user can view all expenses if logged in
    # if not logged in, redirect to login
    get '/expenses', auth: true do 
      @expenses = current_user.expenses
      @total = current_user.total_amount
      erb :'expenses/index'
    end
  
    # user creates an expense if logged in
    get '/expenses/new', auth: true do
      erb :'expenses/new'
    end
    
    # shows only the total of expenses after a set date
    get '/expenses/total' do
      if params[:after_date].present?
        @after_date = params[:after_date]
        @total = current_user.expenses.where("date >= ?", params[:after_date]).sum(:total)
      else
        @total = current_user.total_amount
      end
      erb :"/expenses/total"
    end

    # user must fill in all fields to create an expense
    post '/expenses' do
      if !params[:expense].select{|k, v| v == ""}.empty?
        flash[:message] = "Please don't leave blank content"
        redirect to "/expenses/new"
      else
        @user = current_user
        @expense = Expense.create(params[:expense])
        redirect to "/expenses/#{@expense.id}"
      end
    end
  
    # shows one expense
    get '/expenses/:id', auth: true do
      @expense = Expense.find(params[:id])
      erb :'expenses/show'
    end
  
    # if logged in, user sees edit form
    # user can only edit expenses they created
    get '/expenses/:id/edit', auth: true do
      @expense = Expense.find(params[:id])
      if @expense.user == current_user
        erb :'expenses/edit'
      else
        redirect to '/expenses'
      end
    end
  
    # does not let a user edit a text with blank content
    patch '/expenses/:id' do
      if params[:expense].select{|k, v| v == ""}.empty?
        @expense = Expense.find(params[:id])
        @expense.update(params[:expense])
        @expense.save
        redirect to "/expenses/#{@expense.id}"
      else
        flash[:message] = "Please fill all content"
        redirect to "/expenses/#{params[:id]}/edit" # LOOK
      end
    end

    # if logged in, user can delete expense they created
    delete '/expenses/:id/delete', auth: true do
      @expense = Expense.find(params[:id])
      @expense.user == current_user
      @expense.destroy
      redirect to '/expenses'
    end 
end