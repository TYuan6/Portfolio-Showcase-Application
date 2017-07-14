class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :name
      t.string :description
      t.string :portfolio_style
      t.string :generated_link
      t.references :user
      t.datetime :updated_on
      t.timestamps null: false
      t.boolean :randomStyle
      t.string :template
      t.boolean :public_view
    end
  end
  def down
    drop_table :portfolios
  end
end
