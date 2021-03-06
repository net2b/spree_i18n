module Spree
  class Admin::TranslationsController < Admin::BaseController
    before_filter :load_parent

    helper_method :collection_url
    helper 'spree_i18n/locale'

    def index
      render resource_name
    end

    private
      def load_parent
        set_resource_ivar(resource)
      end

      def resource_name
        params[:resource].singularize
      end

      def set_resource_ivar(resource)
        instance_variable_set("@#{resource_name}", resource)
      end

      def klass
        @klass ||= "Spree::#{params[:resource].classify}".constantize
      end

      def resource
        @resource ||= if klass.respond_to?(:friendly)
          klass.friendly.find(params[:resource_id])
        else
          klass.find(params[:resource_id])
        end
      end

      def collection_url
        ActionController::Routing::Routes.recognize_path("admin_#{resource_name}_url", @resource)
        send "admin_#{resource_name}_url", @resource
      rescue
        send "edit_admin_#{resource_name}_url", @resource
      end
  end
end
