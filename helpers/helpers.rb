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



  def get_with_options(options, required: true, default: nil)
    action = ""
    id = nil
    loop do
      puts options.join(" | ")
      print "> "
      action, id = gets.chomp.split
      break if options.include?(action) || (action.nil? && !required)

      puts "Invalid option"
    end

    action.nil? && default ? [default] : [action, id]
  end

  def login_menu
    get_with_options(["login", "create_user", "exit"])
  end

  def notes_menu
    get_with_options(["create", "update", "delete", "toggle", "trash", "logout"])
  end

  def trash_menu
    get_with_options(["delete", "recover", "back"])
  end
end
