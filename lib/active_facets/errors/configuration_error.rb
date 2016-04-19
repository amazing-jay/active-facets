module ActiveFacets
  module Errors
    class ConfigurationError < StandardError

      RESOURCE_ERROR_MSG            = 'unable to identify resource class'
      STACK_ERROR_MSG               = "self referencing attribute declaration"
      ALL_ATTRIBUTES_ERROR_MSG      = "publish name (:all_attributes) reserved"
      ALL_FIELDS_ERROR_MSG          = "publish name (:all) reserved"
      COMPILED_ERROR_MSG            = "field set configuration not compiled"
      FIELD_SET_ERROR_MSG           = "invalid field set"
      ACTS_AS_ERROR_MSG             = "filters can only be defined on acts_as_active_facets resources"

    end
  end
end
