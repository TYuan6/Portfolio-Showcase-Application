class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.text :link
      t.string :title
      t.string :uid
      t.references :proj
      

      t.timestamps null: false
    end
  end
  def down
    drop_table :videos
  end

end
