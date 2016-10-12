class CreateSearchTags < ActiveRecord::Migration[5.0]
  def change
    create_table :search_tags do |t|
      t.string :tag
      t.date :search_tag_date
      t.integer :created_by

      t.timestamps
    end
  end
end
