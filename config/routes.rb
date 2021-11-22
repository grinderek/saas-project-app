Rails.application.routes.draw do

  resources :user_projects
  resources :members
  resources :artifacts
  class Subdomain
    def self.matches?(request)
      subdomains = %w{ www admin }
      request.subdomain.present? && !subdomains.include?(request.subdomain)
    end
  end

  constraints Subdomain do
    resources :projects do
      get 'users', on: :member
      put 'add_user', on: :member
    end
  end

  devise_for :users, :controllers => {
    :registrations => "registrations",
    :invitations => "invitations",
  }
  root 'home#index'
end
