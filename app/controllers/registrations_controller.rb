class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, :only => [:create]

  def create
    build_resource(sign_up_params)
    resource.add_role(params[:user][:roles])

    if resource.save
      # render text: "Thank you! You will receive an SMS shortly with verification instructions."
      
        # Instantiate a Twilio client
        client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
      
        # Create and send an SMS message
        client.account.sms.messages.create(
          from: TWILIO_CONFIG['from'],
          to: @user.phone,
          body: "Thanks for signing up. To verify your account, please reply HELLO to this message."
        )
      yield resource if block_given?
      if resource.active_for_authentication?
        

        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :email, :phone, :password, :street1, :city, :state, :zip, :latitude, :longitude) }
    end
end