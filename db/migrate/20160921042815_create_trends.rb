class CreateTrends < ActiveRecord::Migration
  def change
    create_table :trends do |t|
      t.integer :site_id
      t.string :name
      t.date :trend_date
      t.integer :rank

      t.timestamps null: false
    end
  end
end
