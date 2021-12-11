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

      puts "Cannot be blank"
    end
    input.empty? ? nil : input
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
