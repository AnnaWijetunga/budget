class User < ActiveRecord::Base
  has_secure_password
  has_many :expenses

  def total_amount
    self.expenses.collect {|expense| expense.total}.sum
  end

  def expenses_sort_by_date
    self.expenses.sort_by {|expense| expense[:date]}.reverse
  end

end