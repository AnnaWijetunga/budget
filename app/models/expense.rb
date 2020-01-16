class Expense < ActiveRecord::Base
  validates_presence_of [:description, :vendor, :total, :date]
  belongs_to :user
end