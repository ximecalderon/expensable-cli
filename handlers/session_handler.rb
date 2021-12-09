module SessionHandler
  def login
    credentials = credentials_form
    @user = Services::Sessions.login(credentials)
    # notes_page
    puts "Welcome back #{@user[:first_name]} #{@user[:last_name]}"
    categories_page
  end
end
