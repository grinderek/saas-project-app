class CreateArtifacts < ActiveRecord::Migration[6.1]
  def change
    create_table :artifacts do |t|
      t.string :name
      t.string :key
      t.belongs_to :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
