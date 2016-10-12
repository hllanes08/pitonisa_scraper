class Add < ActiveRecord::Migration[5.0]
  def change
	rename_column :search_popularizes, :search_id, :search_tag_id
  end
end
