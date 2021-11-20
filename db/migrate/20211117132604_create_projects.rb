class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :details
      t.date :expected_completion_date

      t.timestamps
    end
  end
end
