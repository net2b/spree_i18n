module SpreeI18n
  module Translatable
    extend ActiveSupport::Concern

    def translations_attributes=values
      values.each do |position, data|
        locale = data["locale"].parameterize.downcase.underscore
        data.except("locale").each do |attribute, value|
          send("#{attribute}_#{locale}=", value)
        end
      end
    end
  end
end
