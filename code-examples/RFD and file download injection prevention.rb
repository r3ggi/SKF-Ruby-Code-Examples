# RFD and file download injection prevention

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
	# file1,file2 etc.. for more information about whitelisting see "whitelisting" in the code examples:
	unless check_pattern(input_parameter, ["file1","file2"])
		return false
	end

	# Set proper headers
	response.headers["Cache-Control"] = "nostore, nocache, mustrevalidate, maxage=0"
	response.headers["X-Content-Type-Options"] = "nosniff"
	response.headers["Pragma"] = "nocache"

	# If all went good we can send file based on user's given name
	send_file input_parameter
	return true

end