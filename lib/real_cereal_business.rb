require "real_cereal_business/version"

module RealCerealBusiness
  mattr_accessor :json_attribute_key,
    :json_context_key,
    :opts_key,
    :fields_key,
    :field_overrides_key,
    :version_key,
    :filters_key,
    :cache_force_key,
    :preload_associations,
    :cache_enabled,
    :document_cache,
    :default_cache_options

  #TODO --jdc delete both of these
  self.json_attribute_key             = :group_includes
  self.json_context_key               = :context

  self.opts_key                       = :rsb_opts
  self.fields_key                     = :fields
  self.field_overrides_key            = :field_overrides
  self.version_key                    = :version
  self.filters_key                    = :filters
  self.cache_force_key                = :cache_force

  self.preload_associations           = false
  self.cache_enabled                  = false
  self.default_cache_options          = { expires_in: 5.minutes }
  self.document_cache                 = ::RealCerealBusiness::DocumentCache

  def self.configure
    yield(self)
  end

  def self.global_filter(name)
    ::RealCerealBusiness::Extensions::ActiveRecord.filters[name] = Proc.new
  end

  def self.resource_mapper
    ::RealCerealBusiness::ResourceManager.resource_mapper = Proc.new
  end
end

ActiveRecord::Base.send :include, ::RealCerealBusiness::Extensions::ActiveRecord
ActiveRecord::Relation.send :include, ::RealCerealBusiness::Extensions::ActiveRelation


