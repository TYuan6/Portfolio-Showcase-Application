class CreateGroupCsses < ActiveRecord::Migration
  def change
    create_table :group_csses do |t|
      t.boolean :visible
      t.references :group
      t.references :portfolio
      
      t.string :defaultStyle 
      t.string :position
      t.string :width
      t.string :height
      t.integer :top
      t.integer :left
      
      t.string :font
      t.integer :fontSize
      t.string :color
      
      t.string :backgroundColor
      t.float :opacity
      
      t.integer :borderRadius
      t.string :borderColor
      t.integer :borderSize

      t.string :boxShadow
      t.string :hover

      t.boolean :background
      
      t.timestamps null: false
    end
  end
  def down
    drop_table :group_csses
  end
end
