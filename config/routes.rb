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
    resources :projects
  end

  devise_for :users
  root 'home#index'
end
