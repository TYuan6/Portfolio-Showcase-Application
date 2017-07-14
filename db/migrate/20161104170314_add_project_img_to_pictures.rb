class AddProjectImgToPictures < ActiveRecord::Migration
  def change
     add_attachment :pictures, :project_img
  end
  def down
    remove_attachment :pictures, :project_img
  end
end
