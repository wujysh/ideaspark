class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title,   :null => false, :default => ""
      t.string :content, :null => false, :default => ""
      t.integer :phrase, :null => false, :default => 0

      t.timestamps
    end
  end
end
