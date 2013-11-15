module UserHelper
	def get_deals
		User.get_all.to_json.html_safe
	end
end
