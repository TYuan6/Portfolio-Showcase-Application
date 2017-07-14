class CreateProjs < ActiveRecord::Migration
  def change
    create_table :projs do |t|
      t.string :name
      t.string :link
      t.string :description
      t.datetime :begin_date
      t.datetime :end_date
      t.string :impact
      t.string :keywords
      t.string :collaborator_emails
      t.references :category
      t.references :user
      t.references :group
      t.timestamps null: false
    end
  end
  def down
    drop_table :projs
  end
end
