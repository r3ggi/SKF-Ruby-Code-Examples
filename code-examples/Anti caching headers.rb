# Anti caching headers

# Example:

# Add the following code to APP_DIR/config/environments/production.rb in order to prevent the browser from caching

config.action_controller.perform_caching = false
config.public_file_server.headers = {
  'Cache-Control' => 'no-cache'
}
config.action_dispatch.default_headers = {  
  'Pragma' => 'no-cache' 
} 
