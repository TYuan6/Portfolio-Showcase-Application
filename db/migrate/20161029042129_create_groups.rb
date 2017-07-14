class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name 
      t.text :description
      t.references :user
      #t.references 'projects' ## group:project=0/1:0/n, therefore, projects references groups
      t.timestamps null: false
    end
  end
  def down
    drop_table :groups
  end
end
