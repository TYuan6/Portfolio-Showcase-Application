class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.references :proj
      t.references :user
      t.timestamps null: false
    end
  end
  def down
    drop_table :pictures
  end
end
