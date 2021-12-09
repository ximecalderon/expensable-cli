# Start here. Happy coding!
require "terminal-table"
require_relative "helpers/helpers"
require_relative "services/user"
require_relative "services/session"
require_relative "services/transaction"
require_relative "services/category"
require_relative "handlers/session_handler"

class ExpensableApp
  include Helpers
  include SessionHandler

  def initialize
    @user = nil
    @transactions = []
    # más variables?
  end

  def start
    puts welcome
    action = ""
    until action == "exit"
      begin
        action = login_menu[0]
        case action
        when "login" then login
        when "create_user" then puts "create_user" # modificar
        when "exit" then puts goodbye
        end
      rescue HTTParty::ResponseError => e
        parsed_error = JSON.parse(e.message)
        puts parsed_error["errors"]
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
