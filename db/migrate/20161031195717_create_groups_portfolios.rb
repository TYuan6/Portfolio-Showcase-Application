class CreateGroupsPortfolios < ActiveRecord::Migration
  def change
    create_table :groups_portfolios, :id => false do |t|
      t.references :group
      t.references :portfolio
    end
  end
  def down
    drop_table :groups_portfolios
  end
end
