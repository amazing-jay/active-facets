ActiveFacets.configure do |config|
  config_file_path = File.join(Rails.root, 'config', 'active_facets.yml')
  environment = ENV["RAILS_ENV"] || ENV["RACK_ENV"] || 'development'

  @config_file = YAML::load_file(config_file_path)
  @env_config = (@config_file['default'] || {}).merge(@config_file[environment] || {})

  # The version to use if none is designated in context for serialization. 1.0 by default.
  # config.default_version                = 1.0

  # The symbol which acts as the options key that designates context for serialization. :rsb_opts by default.
  # config.opts_key                       = @env_config['opts_key'].to_sym

  # The symbol which acts as the context key that designates fields for serialization. :fields by default.
  # config.fields_key                     = @env_config['fields_key'].to_sym

  # The symbol which acts as the context key that designates field overrides for serialization. :field_overrides by default.
  # config.field_overrides_key            = @env_config['field_overrides_key'].to_sym

  # The symbol which acts as the context key that designates version for serialization. :version by default.
  # config.version_key                    = @env_config['version_key'].to_sym

  # The symbol which acts as the context key that designates filters for serialization. :filters by default.
  # config.filters_key                    = @env_config['filters_key'].to_sym

  # The symbol which acts as the context key that designates force for cache. :cache_force by default.
  # config.cache_force_key                = @env_config['cache_force_key'].to_sym

  # The symbol which acts as the context key that designates filters state override. :filters_force by default.
  # config.filters_force_key              = @env_config['filters_force_key'].to_sym

  # Tell if exception should be raised when serializer_mapper returns nil. False by default.
  # config.strict_lookups                 = @env_config['strict_lookups']

  # Tell if associations should be preloaded to mitigate N+1 problems. False by default.
  # config.preload_associations           = @env_config['preload_associations']

  # Tell serializers to cache
  # config.cache_enabled                  = @env_config['cache_enabled']

  # Tell ActiveRecord to treat enable acts_as_active_facet for all models. False by default.
  # config.acts_as_active_facet_enabled   = @env_config['acts_as_active_facet_enabled']

  # Tell serializers to enable/disable filters
  # config.filters_enabled                = @env_config['filters_enabled']

  # Default options for Rails.cache.fetch
  # config.default_cache_options          = { expires_in: 5.minutes }

  # Tell document cache adaptor to use
  # config.document_cache = ::ActiveFacets::DocumentCache

  # Tell which filters and field_overrides apply to a given resource
  # config.resource_mapper do |resource_class|
  #   [].tap do |map|
  #     until(resource_class.superclass == BasicObject) do
  #       map << resource_class.name.tableize
  #       resource_class = resource_class.superclass
  #     end
  #   end
  # end

  # Tell which serializer to apply for a given resource
  # config.serializer_mapper do |resource_class, serializer, type, version, options|
  #   case type
  #   when :serializer
  #     (version.to_s + '::' + resource_class.name.camelcase + type.to_s.camecase).constantize.new
  #   else
  #     (version.to_s + '::' + resource_class.name.camelcase + type.to_s.camecase).constantize
  #   end
  # end

  # Define global filters to apply for all resources
  # config.global_filter(:active) do |state = :enabled|
  #   case state.to_sym
  #   when :enabled
  #     enabled if respond_to?(:enabled)
  #   when :disabled
  #     disabled
  #   end
  # end
end
