class Devise::Custom::RegistrationsController < Devise::RegistrationsController
  
  before_filter :configure_permitted_parameters, :only => [:create]
  
  def new
    super
  end
  
  protected

     def configure_permitted_parameters
       devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:surname, :name, :patronymic, :group_id, :email, :password) }
     end
end