module RealCerealBusiness
  module Errors
    class ConfigurationError < StandardError

      RESOURCE_ERROR_MSG            = 'unable to identify resource class'
      STACK_ERROR_MSG               = "self referencing attribute declaration"
      ALL_ATTRIBUTES_ERROR_MSG      = "publish name (:all_attributes) reserved"
      ALL_FIELDS_ERROR_MSG          = "publish name (:all) reserved"
      COMPILED_ERROR_MSG            = "field set configuration not compiled"

    end
  end
end
