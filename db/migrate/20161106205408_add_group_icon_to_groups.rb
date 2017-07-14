class AddGroupIconToGroups < ActiveRecord::Migration
  def change
    add_attachment :groups, :group_icon
  end
  def down
    remove_attachment :groups, :group_icon
  end
end
