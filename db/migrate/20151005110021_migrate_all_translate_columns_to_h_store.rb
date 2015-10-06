require 'trasto'

class MigrateAllTranslateColumnsToHStore < ActiveRecord::Migration
  TABLES_AND_COLUMNS = {
    spree_option_types:        [:name, :presentation],
    spree_option_values:       [:name, :presentation],
    spree_products:            [:name, :description, :meta_description, :meta_keywords, :slug],
    spree_product_properties:  [:value],
    spree_promotions:          [:name, :description],
    spree_properties:          [:name, :presentation],
    spree_taxons:              [:name, :description, :meta_title, :meta_description, :meta_keywords, :permalink],
    spree_taxonomies:          [:name],
  }

  def change
    type = Trasto.supports_hstore? ? :hstore : :text
    TABLES_AND_COLUMNS.each do |table, columns|
      columns.each do |column|
        add_column table, "#{column}_i18n", :hstore
      end
    end
  end
end
