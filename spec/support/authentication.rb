module Authentication
  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryBot.create(:user)
    sign_in user
  end

  def logout_user(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_out user
  end
end
