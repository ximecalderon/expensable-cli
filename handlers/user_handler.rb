module UserHandler
  def create_user
    credentials = credentials_form
    @user = Services::Users.signup(credentials)
    notes_page
  end
end
