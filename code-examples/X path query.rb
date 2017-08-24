# X Path query

require "Nokogiri"

# Include the classes where you want to make objects of:
require_relative "classes"

class xPathControl
	# Define the allowed characters and input parameter and countlevel for the
	# user lockout like:
	# controller(params[:filename], "<'>&")

	def controller(input_param, allowed_characters)
		encoder = Encoder.new
		encoded = Encoder.encoder(input_param, allowed_characters)

		if encoded
			doc = Nokogiri::XML(File.read("file.xml"))

			# Assuming that you used the encoder function also for adding users, it will now retrieve the
			# user O'reily from the query
    		query_result = doc.xpath('//lemonade[@supplier="'+doc+'"]/price')
		end
	end 
end