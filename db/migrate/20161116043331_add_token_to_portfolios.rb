class AddTokenToPortfolios < ActiveRecord::Migration
  def change
    add_column :portfolios, :token, :string
    add_column :portfolios, :publicLink, :text
  end
  def down
    remove_column :portfolios, :token, :string
    remove_column :portfolios, :publicLink, :text
  end
end
