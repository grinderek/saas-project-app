class AddSubdomainToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :subdomain, :string
    add_index :users, :subdomain
  end
end
