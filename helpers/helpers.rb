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

    # input
    input.empty? ? nil : input
  end

  
  
  def get_string_regex(label,regex,prompt,optional: false)
    input = ""
    loop do
      print "#{label}: "
      input = gets.chomp
      break if input.empty? && optional
      break if input =~ regex 
      # break unless input.empty? && required
      puts prompt

    end
    input.empty? ? nil : input
    # input

end


  
  def user_form
    email = get_string_regex("Email",/^\w*@\w*\.\w{3}$/, "Invalid format")
    password = get_string_regex("Password",/^\w{6,}$/, "Minimum 6 characters")
    first_name = get_string("First_name")
    last_name = get_string("Last_name")
    phone = get_string_regex("Phone",/(^[+]51\s{1}\d{9}$|^\d{9}$)/, "Required format: +51 111222333 or 111222333", optional: true)
    { email: email, password: password, first_name: first_name, last_name: last_name, pho: phone }
  end
  
  
  
  def credentials_form
    email = get_string("Email", required: true)
    password = get_string("Password", required: true)
    
    { email: email, password: password }
  end
  
  def get_with_options(options1, options2 = nil)
    puts options1.join(" | ")
    puts options2.join(" | ") unless options2.nil?
    print "> "
    action, id = gets.chomp.split
    id = id.to_i if !id.nil? && id.match(/^\d+$/)
    [action, id]
  end
  
  def get_string_regex(label, regex, prompt, optional: false)
    input = ""
    loop do
      print "#{label}: "
      input = gets.chomp
      break if input.empty? && optional
      break if input =~ regex
      
      # break unless input.empty? && required
      puts prompt
    end
    input.empty? ? nil : input
  end
  
  
  def category_form
    name = get_string("Name", required: true)
    transaction_type = get_string_regex("transaction_type", /(^income$|^expense$)/, "Only income or expense")
    { name: name, transaction_type: transaction_type }
  end

  def transaction_form
    amount = get_string_regex("Amount", /^[1-9][0-9]+$|^[1-9]$/, "Cannot be zero").to_i
    date = get_string_regex("Date", /^\d{4}-\d{2}-\d{2}$/, "Required format: YYYY-MM-DD")
    notes = get_string("Notes", required: false)
    { amount: amount, date: date, notes: notes }
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

  def find_category(category_id)
    @categories.find do |category|
      category[:id] == category_id
    end
  end
end
