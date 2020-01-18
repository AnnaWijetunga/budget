require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use ExpensesController
use UsersController
run ApplicationController

# The purpose of config.ru is to detail to Rack 
# the environment requirements of the application 
# and start the application.