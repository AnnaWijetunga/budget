class User < ActiveRecord::Base
  has_secure_password # ActiveRecord macro, works with bcrypt, gives us methods to authenticate a user/password 
  has_many :expenses

  def total_amount
    expenses.collect {|expense| expense.total}.sum
  end

  def expenses_sort_by_date
    expenses.sort_by {|expense| expense[:date]}.reverse
  end

end