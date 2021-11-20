class Project < ApplicationRecord
  validates_uniqueness_of :title
  has_many :artifacts, dependent: :destroy
  has_many :user_projects
  has_many :users, through: :user_projects

  accepts_nested_attributes_for :artifacts, allow_destroy: true
end
