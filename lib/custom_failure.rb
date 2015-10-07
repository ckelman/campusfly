class CustomFailure < Devise::FailureApp
    def redirect_url   
       root_path(:signin_error => 'true', :email => params['user']['email'], :remember_me => params['user']['remember_me'])
    end

    # You need to override respond to eliminate recall
    def respond
      if http_auth?
        http_auth
      else
        redirect
      end
    end
  end