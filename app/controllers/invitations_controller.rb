class InvitationsController < Devise::InvitationsController
  private

    # This is called when creating invitation.
    # This is called when accepting invitation.
    # It should return an instance of resource class.
    def accept_resource
      resource = resource_class.accept_invitation!(update_resource_params)
      # Report accepting invitation to analytics
      # Analytics.report('invite.accept', resource.id)
      resource[:subdomain] = request.subdomain
      resource[:is_admin] = false
      resource.save
      resource
    end
end
