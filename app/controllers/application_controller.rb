class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect_to_subdomain
  before_action :set_mailer_host

  private

  def redirect_to_subdomain
    return if self.is_a?(DeviseController)
    if current_user.present? && request.subdomain != current_user.subdomain
      redirect_to projects_url(subdomain: current_user.subdomain)
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    root_url(subdomain: resource_or_scope.subdomain)
  end

  def set_mailer_host
    subdomain = current_user ? "#{current_user.subdomain}." : nil

    if subdomain.nil? && params[:user]
      subdomain = "#{params[:user][:subdomain]}."
    end

    # ActionMailer::Base.default_url_options[:host] = "#{subdomain}lvh.me:3000"
    ActionMailer::Base.default_url_options[:host] = "#{subdomain}saas-project-app-23.herokuapp.com"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :subdomain])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :subdomain])
  end
end
