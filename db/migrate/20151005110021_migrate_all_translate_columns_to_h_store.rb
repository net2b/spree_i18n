require 'trasto'

class MigrateAllTranslateColumnsToHStore < ActiveRecord::Migration
  def up
    {
      spree_option_types:        [:name, :presentation],
      spree_option_values:       [:name, :presentation],
      spree_products:            [:name, :description, :meta_description, :meta_keywords, :slug],
      spree_product_properties:  [:value],
      spree_promotions:          [:name, :presentation],
      spree_properties:          [:name, :presentation],
      spree_taxons:              [:name, :description, :meta_title, :meta_description, :meta_keywords, :permalink],
      spree_taxonomies:          [:name],
    }.each do |table, columns|
      columns.each do |column|
        if Trasto.supports_hstore?
          add_column table, "#{column}_i18n", :hstore
        else
          add_column table, "#{column}_i18n", :text, default: nil
        end
      end
    end
  end
end
