require "terminal-table"
require "date"
require_relative "helpers/helpers"
require_relative "services/user"
require_relative "services/session"
require_relative "services/categories"
require_relative "services/transactions"
require_relative "handlers/user_handler"
require_relative "handlers/session_handler"
require_relative "handlers/categories_handler"
require_relative "handlers/transactions_handler"

class ExpensableApp
  include Helpers
  include SessionHandler
  include CategoriesHandler
  include TransactionsHandler
  include UserHandler

  def initialize
    @user = nil
    @categories = []
    @transactions = []
    @date = Date.today
    @expense = true
  end

  def start
    puts welcome
    action = ""
    until action == "exit"
      begin
        action = login_menu[0]
        case action
        when "login" then login
        when "create_user" then create_user
        when "exit" then puts goodbye
        else puts "Invalid option"
        end
      rescue HTTParty::ResponseError => e
        parsed_error = JSON.parse(e.message)
        puts parsed_error["errors"]
      end
    end
  end

  def categories_page
    @categories = Services::Categories.index_categories(@user[:token])
    action = ""

    until action == "logout"
      puts categories_table
      action, id = categories_menu
      case action
      when "create" then create_category
      when "show" then transactions_page(id)
      when "update" then  update_category(id)
      when "delete" then  delete_category(id)
      when "add-to" then add_transaction(id)
      when "toggle" then toggle
      when "next" then next_month_categories
      when "prev" then prev_month_categories
      when "logout" then logout
      else puts "Invalid option"
      end
    end
  end

  def transactions_page(category_id)
    @transactions = Services::Transactions.index_transactions(@user[:token], category_id)
    action = ""

    until action == "back"
      begin
        puts transactions_table(category_id)
        action, id = transactions_menu
        case action
        when "add" then add_transaction(category_id)
        when "update" then update_transaction(category_id, id)
        when "delete" then delete_transaction(category_id, id)
        when "next" then next_month_transactions(category_id)
        when "prev" then prev_month_transactions(category_id)
        when "back" then nil
        else puts "Invalid option"
        end
      rescue HTTParty::ResponseError => e
        parsed_error = JSON.parse(e.message)
        puts parsed_error
      end
    end
  end
end
