class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :get_sidebar_params

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email)}
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, 
                                                            :voter_id, :state_code, :house_district_id,
                                                            :name, :address, :address2, :city, :zip) }
  end

  def get_sidebar_params
    @congress = Congress.where("current = ?", true).first
    @cdata = CongressDatum.find_by_congress(@congress.number)
  end

end
