# Start here. Happy coding!
require "terminal-table"
require_relative "helpers/helpers"
require_relative "services/user"
require_relative "services/session"
require_relative "handlers/session_handler"
require_relative "services/categories"
require_relative "services/transactions"

class ExpensableApp
  include Helpers
  include SessionHandler

  def initialize
    @user = nil
    @categories = []
    # más variables?
  end

  def start
    puts welcome
    action = ""
    until action == "exit"
      # begin
      #   action = login_menu[0]
      #   case action
      #   when "login" then login
      #   when "create_user" then puts "create_user" # modificar
      #   when "exit" then puts goodbye
      #   end
      # rescue HTTParty::ResponseError => e
      #   parsed_error = JSON.parse(e.message)
      #   puts parsed_error["errors"]
      action = login_menu

      case action
      when "login" then login # modificar => class sessions
      when "create_user" then puts "create_user" # modificar => class users
      when "exit" then puts goodbye
      else puts "Invalid option"
      end
    end
  end

  def categories_page
    @categories = Categories.index_categories(@user[:token])
    action = ""

    until action == "logout"
        begin
          puts expenses_table
          action, id = categories_menu
          case action
          when "create" then puts "create_note"
          when "show ID" then puts "update_note(id)"
          when "update ID" then puts "delete_note(id)"
          when "delete ID" then puts "toggle(id)"
          when "add-to ID" then puts "add-to(id)"
          when "toggle" then puts "toggle"
          when "next" then puts "next"
          when "prev" then puts "prev"
          else puts "Invalid option"
          end
        rescue HTTParty::ResponseError => e
          parsed_error = JSON.parse(e.message)
          puts parsed_error
        end
      end
  end

  def categories_table(transaction_type)
    categories_data = @categories.select do |category|
        category[:transaction_type] == transaction_type
    end

    table = Terminal::Table.new
    table.title = transaction_type.capitalize
    table.headings = ["ID", "Category", "Total"]
    table.rows = categories_data.map do |category|
      [category[:id], category[:name], category[:transactions].size]
    end
    table
  end

  def expenses_table
    categories_table("expenses")
  end

  def income_table
    categories_table("income")
  end

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
