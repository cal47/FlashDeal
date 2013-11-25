class UserController < ApplicationController
  def create
  end

  def show
  	@user = current_user
  end

  def edit
  	@user = current_user
  end

  
end
