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

end


# email = get_string_regex("Email",/^\w*@\w*\.\w{3}$/, "Invalid format" )
email = get_string_regex("Email",/^\w*@\w*\.\w{3}$/, "Invalid format")
p email
password = get_string_regex("Password",/^\w{6,}$/, "Minimum 6 characters")
p password
phone = get_string_regex("Phone",/(^[+]51\s{1}\d{9}$|^\d{9}$)/, "Required format: +51 111222333 or 111222333", optional: true)
p phone

