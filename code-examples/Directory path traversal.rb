# Directory/path traversal

# Include the classes of which you want to use objects from
require_relative "classes"

def get_files(input_parameter, pattern)

	validator = Validation.new

	# First, we want to filter the filenames for expected values. For this example we use only az/09
	# Whenever the values are tampered with, we can assume an attacker is trying to inject malicious input.
	# for more information about validation see "input validations" in the code examples:
	unless validator.alphanumeric? input_parameter
		return false
	end

	# Second, we want to whitelist the filenames for expected values, in this example they are,
	# page1,page2 etc.. for more information about whitelisting see "whitelisting" in the code examples:
	unless check_pattern(input_parameter, ["page1","page2"])
		return false
	end

	#If all went good we can send file based on user's given name
	send_file input_parameter
	return true

end