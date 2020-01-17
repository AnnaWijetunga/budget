class ExpensesController < ApplicationController

    # user can view all expenses if logged in
    # if not logged in, redirect to login
    get '/expenses' do
      if logged_in?
        @expenses = current_user.expenses
        erb :'expenses/index'
      else
        redirect to '/login'
      end
    end
  
    # user creates an expense if logged in
    get '/expenses/new' do
      if logged_in?
        erb :'expenses/new'
      else
        redirect to '/login'
      end
    end
  
    # user must fill in all fields to create an expense
    post '/expenses' do
      if !params[:expense].select{|k, v| v == ""}.empty?
        flash[:message] = "Please don't leave blank content"
        redirect to "/expenses/new"
      else
        @user = current_user
        @expense = Expense.create(params[:expense])
        redirect to "/expenses/#{@expense.id}" # LOOK
      end
    end
  
    # shows one expense
    get '/expenses/:id' do
      if logged_in?
        @expense = Expense.find(params[:id])
        erb :'expenses/show'
      else
        redirect to '/login'
      end
    end
  
    # if logged in, user sees edit form
    # user can only edit expenses they created
    get '/expenses/:id/edit' do
      if logged_in?
        @expense = Expense.find(params[:id])
        if @expense.user == current_user
          erb :'expenses/edit'
        else
          redirect to '/expenses'
        end
      else
        redirect to '/login'
      end
    end
    
    # get '/expenses/:id/edit' do
    #   @expense = Expense.find(params[:id])
    #   if logged_in? && @expense.user == current_user
    #     @expense = Expense.find(params[:id])
    #     @user = User.find(session[:user_id])
    #     erb :'expenses/edit'
    #   else
    #     redirect to '/login'
    #   end
    # end
  
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

   #shows only expenses with the given description
   get '/expenses/total/:total' do
    #  @vendor = params[:vendor]
    #  @filtered_expenses = current_user.expenses_by_vendor(@vendor)
     erb :"/expenses/total"
   end
  
    delete '/expenses/:id/delete' do
      @expense = Expense.find(params[:id])
      if logged_in? && @expense.user == current_user
        @expense.destroy
        #flash[:message] = "Your expense has been deleted."
        redirect to '/expenses'
      else
        redirect to '/login'
      end
    end 
end