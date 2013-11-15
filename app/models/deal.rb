class Deal < ActiveRecord::Base
	resourcify

	def user_params 
  	params.require(:user).permit(:deal)
  end

end
