class RenamaTypeForSiteType < ActiveRecord::Migration
  def change
	rename_column :sites, :type, :site_type
  end
end
