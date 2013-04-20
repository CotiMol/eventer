class AddVisibilityAndOrderToCategory < ActiveRecord::Migration
  def up
		add_column :categories, :visible, :boolean
		add_column :categories, :order, :integer
	end
	
	def down
		remove_column :categories, :visible
		remove_column :categories, :order
	end
end
