class User < ActiveRecord::Base
  has_secure_password # ActiveRecord macro, works with bcrypt, gives us methods to authenticate a user/password 
  has_many :expenses #ActiveRecord association - SQL command to read foreign keys, connects users with expenses
  validates :email, uniqueness: true
  
  def total_amount
    expenses.collect {|expense| expense.total}.sum
  end

  def expenses_sort_by_date
    expenses.sort_by {|expense| expense[:date]}.reverse
  end

end

# A has_many association indicates a one-to-many connection with another model. 
# This association indicates that each instance of the model has 
# zero or more instances of another model.