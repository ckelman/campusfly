class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
		user = User.from_omniauth(request.env["omniauth.auth"])
		if user.persisted?
			sign_in_and_redirect user
		else
			session["devise.user_attributes"] = user.attributes
			session["from_facebook"] = true
			redirect_to root_path(:from_facebook => true)

			# redirect_to root_path(:from_facebook => true, :user_att => user.attributes)
		end
	end
end
