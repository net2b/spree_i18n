module SpreeI18n
  module Translatable
    extend ActiveSupport::Concern

    def translations_attributes=values
      raise values
    end
  end
end
