class User < ActiveRecord::Base
  rolify

  def user_params 
  	params.require(:user).permit(:first_name, :last_name, :email, :role)
  end

  # attr_accessible :role_ids
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def vendor_or_above_roles
  	self.has_role?(:vendor) || self.has_role?(:admin)
  end
end
