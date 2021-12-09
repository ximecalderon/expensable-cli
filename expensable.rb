# Start here. Happy coding!
require "terminal-table"
require_relative "helpers/helpers"
require_relative "services/user"
require_relative "services/session"
require_relative "services/transaction"
require_relative "services/category"

class ExpensableApp
  include Helpers

  def initialize
    @user = nil
    @transactions = []
    # más variables?
  end

  def start
    puts welcome
    action = ""
    until action == "exit"
      action = login_menu[0]

      case action
      when "login" then puts "login" # modificar
      when "create_user" then puts "create_user" # modificar
      when "exit" then puts goodbye
      end
    end
  end

  def expenses_page
    # Transactions.find do |transaction|
    # transaction[:transaction_type] == expenses
    # end
  end

  def income_page
    # Transactions.find do |transaction|
    # transaction[:transaction_type] == income
    # end
  end

  def category_page; end

  def toggle
    # if actual_page income_page
    # expenses_page
    # elsif actual_page expenses_page
    # income_page
    # end
  end
end

app = ExpensableApp.new
app.start
