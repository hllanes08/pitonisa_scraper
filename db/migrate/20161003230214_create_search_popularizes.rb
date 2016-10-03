class CreateSearchPopularizes < ActiveRecord::Migration[5.0]
  def change
    create_table :search_popularizes do |t|
      t.string :tag
      t.integer :search_id
      t.integer :index

      t.timestamps
    end
  end
end
