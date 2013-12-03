class User < ActiveRecord::Base
  rolify

  has_many :deals

  with_options if: :vendor_role? do |vendor|
    vendor.validates :street1, :presence => :true
    vendor.validates :city, :presence => :true
    vendor.validates :state, :presence => :true
    vendor.validates :zip, :presence => :true
  end

  geocoded_by :geo_address
  after_validation :geocode, if: :address_change

  def user_params 
  	params.require(:user).permit(:first_name, :last_name, :email, :street1, :street2, :city, :state, :zip, :latitude, :longitude, :phone)
  end

  # attr_accessible :role_ids
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def vendor_or_above_roles
  	self.has_role?(:vendor) || self.has_role?(:admin)
  end

  def vendor_role?
    self.has_role?(:vendor)
  end

  def geo_address
    self.address = self.street1+", "+self.city+", "+self.state+", "+self.zip.to_s
    self.address
  end

  def address_change
    if :street1_changed? || :city_changed? || :state_changed? || :zip_changed?
      true
    end
  end

end
