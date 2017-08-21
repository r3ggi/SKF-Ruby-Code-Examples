# Session hijacking and fixation

# In order to secure your session, you have to turn on SECURE and HTTPONLY cookies' flags
# More info in: "Session cookies HTTPOnly" and "Secure session cookies"

# Turn on Strict Transport Security Header in the ApplicationController
class ApplicationController < ActionController::Base
  before_filter :strict_transport_security
  def strict_transport_security
    if request.ssl?
    	# Option 0 - simple version
      	response.headers['Strict-Transport-Security'] = "max-age=31536000;"
      	# Option 1 - if all present and future subdomains will be HTTPS
      	response.headers['Strict-Transport-Security'] = "max-age=31536000; includeSubDomains"
      	# Option 2 - Recommended: If the site owner would like their domain to be included in the HSTS preload
    	# list maintained by Chrome (and used by Firefox and Safari), then use:
		response.headers['Strict-Transport-Security'] = "StrictTransportSecurity: maxage=31536000; includeSubDomains; preload"
    end
  end
end

# After that add :trackable symbol to the devise configuration in users' model

# For example:
class User < ApplicationRecord
  has_many :posts

  #Be sure that :trackable is added
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :secure_validatable
end

# Now update controllers that need authenticated users to perform actions.
class ContollerWithAuthenticatedUsers < ApplicationController
  before_action :authenticate_user!
  before_action :check_ip

  private
  # After this modification current users' IP address will be compared to
  # the last IP that was used to log in on the account. If they dont match - 
  # user will be warned. This check will be performed every single user action.
  def check_ip
  	if current_user.last_sign_in_ip != request.remote_ip
  		flash[:warning] = "There are other active sessions on other IPaddresses. " +
  		"Your session could be hijacked. Press logout in order to authenticate again " +
  		"for security reasons!"
  	end
  end  
end

