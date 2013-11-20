class Deal < ActiveRecord::Base
	resourcify

	belongs_to :user

	def user_params 
  	params.require(:user).permit(:deal)
  end

end
