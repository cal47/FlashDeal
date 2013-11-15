module DealsHelper
	def get_deals
		Deal.get_all.to_json.html_safe
	end
end
