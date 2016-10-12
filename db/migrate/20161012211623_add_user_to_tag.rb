class AddUserToTag < ActiveRecord::Migration[5.0]
  def change
	  add_column :search_tags, :user_id, :integer
  end
end
