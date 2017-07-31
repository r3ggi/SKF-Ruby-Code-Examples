# Encoder

# Example

# This is the encoder method for whenever you have to allow certain
# possibly dangerous characters into your code for i.e names such as O'reily

class EncodeInput

	# Application has to protect itself. Every bad input the counter will increment. If the counter
	# hits 3 user's session must be terminated. 
	attr_reader :counter

	def initialize
		@counter = 0
	end

	def encoder(input, allowed_characters)
		pattern = "^[a-zA-Z0-9"+allowed_characters+"]+$"
		regex = Regexp.compile(pattern)

		unless input =~ regex
			@counter += 1

			# Every bad input validation has to be logged.
			Rails.logger.warn "#{session.id} -> Bad user input"

			if @counter >= 3
				# DO LOGOUT HERE
			end

			return false
		end

		return sanitize(input)
	end
end