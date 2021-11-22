class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, request_keys: [:subdomain]

  after_create :create_tenant
  after_destroy :delete_tenant

  has_many :user_projects
  has_many :projects, through: :user_projects

  def is_admin?
    is_admin
  end

  private

  def create_tenant
    byebug
    unless subdomain.nil?
      Apartment::Tenant.create(subdomain)
    end
  end

  def delete_tenant
    Apartment::Tenant.drop(subdomain)
  end

  def self.find_for_authentication(warden_conditions)
    where(email: warden_conditions[:email], subdomain: warden_conditions[:subdomain]).first
  end
end
