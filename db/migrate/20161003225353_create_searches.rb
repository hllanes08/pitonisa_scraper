class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.string :tag
      t.date :search_date

      t.timestamps
    end
  end
end
