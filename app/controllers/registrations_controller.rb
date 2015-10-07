class RegistrationsController < Devise::RegistrationsController


before_filter :configure_permitted_parameters




 def create
    build_resource(sign_up_params)

    if resource.save
        yield resource if block_given?
        if resource.active_for_authentication?
            set_flash_message :notice, :signed_up if is_flashing_format?
            sign_up(resource_name, resource)
            respond_with resource, location: after_sign_up_path_for(resource)
        else
            set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
            expire_data_after_sign_in!
            respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
    else
        clean_up_passwords resource
        resource.errors.full_messages.each {|x| flash[x] = x} # Rails 4 simple way
        redirect_to root_path(:signup_error => 'true', :signup_errors => @user.errors.full_messages, 
          :email => sign_up_params['email'],
          :name => sign_up_params['first_name'],
          :student => sign_up_params['student'],
          :from_facebook =>params['from_facebook']  )
    end
end

  protected

  # my custom fields are :name, :heard_how
  def configure_permitted_parameters    
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:first_name, :last_name, :student,
        :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:first_name, :last_name,
        :email, :password, :password_confirmation, :current_password)
    end
  end


end 