# Identifier based authorization

# Include the classes of which you want to use objects from
require_relative "classes"

def identifier_based_authorization(input_parameter, pattern, id_to_auth)

    validator = Validation.new

    # First, we want to filter the filenames for expected values. For this example we use only numeric
    # Whenever the values are tampered with, we can assume an attacker is trying to inject malicious input.
    # for more information about validation see "input validations" in the code examples:
    unless validator.numeric? input_parameter
        return false
    end

    # Second, we want to whitelist the filenames for expected values, in this example they are,
    # file1,file2 etc.. for more information about whitelisting see "whitelisting" in the code examples:
    unless check_pattern(input_parameter, ["file1","file2"])
        return false
    end

	# Whenever you are checking whether a user is restricted to review certain data,
	# the access restrictions should be processed serverside.
	user_auth_id = User.where("auth_id = ?", input_parameter)
    if id_to_auth == user_auth_id
    	return true
    end

    false
end