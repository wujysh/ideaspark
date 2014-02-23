class CreateManifests < ActiveRecord::Migration
  def change
    create_table :manifests do |t|
      t.belongs_to :idea
      t.references :user
    end
  end
end
