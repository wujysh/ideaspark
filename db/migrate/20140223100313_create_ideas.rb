class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title,   :null => false, :default => ""
      t.string :content, :null => false, :default => ""
      t.integer :phase, :null => false, :default => 0

      t.timestamps
    end
 
    add_index :ideas, :title, unique: true
  end
end
