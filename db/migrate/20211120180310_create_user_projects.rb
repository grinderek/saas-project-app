class CreateUserProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :user_projects do |t|
      t.belongs_to :project
      t.belongs_to :user

      t.timestamps
    end
  end
end
