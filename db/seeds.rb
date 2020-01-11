users = [
{username: "apple", email: "apple@gmail.com", password: "apple"},
{username: "banana", email: "banana@gmail.com", password: "banana"},
{username: "carrot", email: "carrot@gmail.com", password: "carrot"}
]

users.each do |user|
  User.create(user)
end

expenses = [
  {vendor: "Track 5", description: "Coffee", date: "2020-01-01", total: 4.02, user_id: 1},
  {vendor: "&Grain", description: "Lunch", date: "2020-01-02", total: 14.04, user_id: 1},
  {vendor: "Starbucks", description: "Latte", date: "220-01-03", total: 4.00, user_id: 1},
  {vendor: "Boxwood", description: "Latte and Scone", date: "2020-01-04", total: 49.50, user_id: 1},
  {vendor: "Whole Foods", description: "Groceries", date: "2020-01-01", total: 100.00, user_id: 2},
  {vendor: "Green Grocer", description: "Fruit", date: "2020-01-02", total: 16.10, user_id: 2},
  {vendor: "Trader Joe's", description: "Dessert", date: "2020-01-03", total: 12.12, user_id: 2},
  {vendor: "Verizon", description: "Phone Bill", date: "2020-01-01", total: 40.12, user_id: 3},
  {vendor: "PG&E", description: "Electric Bill", date: "2020-01-02", total: 70.02, user_id: 3},
  {vendor: "Summit", description: "Routine Appointment", date: "2020-01-05", total: 30.00, user_id: 3},
]

expenses.each do |expense|
  Expense.create(expense)
end