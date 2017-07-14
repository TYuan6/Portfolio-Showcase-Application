class AddProjIconToProject < ActiveRecord::Migration
  def change
    add_attachment :projs, :proj_icon
  end
  def down
    remove_attachment :projs, :proj_icon
  end
end
