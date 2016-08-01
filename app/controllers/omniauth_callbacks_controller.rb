class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  %w(facebook twitter google_oauth2).each do |provider|
    define_method provider do
      @user = User.from_omniauth request.env["omniauth.auth"]
      if @user.persisted?
        flash[:notice] = t "devise.omniauth_callbacks.success", 
          kind: t("#{provider}")
        sign_in_and_redirect @user, event: :authentication
      else
        session["devise.#{provider}_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end
  end
end
