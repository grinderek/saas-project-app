class RegistrationsController < Devise::RegistrationsController

  protected
  def sign_out_session!()
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name) if user_signed_in?
  end
end