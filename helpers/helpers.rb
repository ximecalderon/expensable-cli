module Helpers
  def welcome
    [
      "####################################",
      "#       Welcome to Expensable      #",
      "####################################"
    ].join("\n")
  end

  def goodbye
    [
      "####################################",
      "#    Thanks for using Expensable   #",
      "####################################"
    ].join("\n")
  end


  def get_string(label, required: false)
    input = ""
    loop do
      print "#{label}: "
      input = gets.chomp
      break unless input.empty? && required

      puts "#{label} can't be blank"
    end
    input.empty? ? nil : input
  end

  def credentials_form
    email = get_string("Email", required: true)
    password = get_string("Password",required: true)

    { email: email, password: password } 
  end

  def get_with_options(options1, options2 = nil, required: true, default: nil) # (options_line1, options_line2 = nil)
    action = ""
    id = nil
    loop do
      puts options1.join(" | ")
      puts options2.join(" | ") unless options2.nil?
      print "> "
      action, id = gets.chomp.split
      break if options1.include?(action) || options2.include?(action) || (action.nil? && !required)
      puts "Invalid option"
    end
    action.nil? && default ? [default] : [action, id]
  end

  def login_menu
    get_with_options(["login", "create_user", "exit"])
  end

  def categories_menu
    get_with_options(
        ["create", "show ID", "update ID", "delete ID"],
        ["add-to ID", "toggle", "next", "prev", "logout"]
    )
  end

  def transactions_menu
    get_with_options(
        ["add", "update ID", "delete ID"],
        ["next", "prev", "back"]
    )
  end
end
