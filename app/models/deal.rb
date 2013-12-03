class Deal < ActiveRecord::Base
	resourcify

	belongs_to :user

	geocoded_by :geo_address
  after_validation :geocode, if: :address_change

  def user_params 
  	params.require(:user).permit(:deal)
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
