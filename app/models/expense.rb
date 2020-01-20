class Expense < ActiveRecord::Base
  belongs_to :user 
end

# ActiveRecord association

# Associations are a set of macro-like class methods 
# for tying objects together through foreign keys

# Foreign key tells tables how to relate to each other

# A belongs_to association sets up a one-to-one connection 
# with another model, such that each instance of the declaring model 
# "belongs to" one instance of the other model.