module UserHandler
  def create_user
    user_data = user_form
    @user = Services::Users.signup(user_data)
    puts "Welcome #{@user[:first_name]} #{@user[:last_name]}"
    categories_page
  end
end
