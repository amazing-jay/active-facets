#TODO --jdc rebuild this class to either not use an explicit singleton pattern or use a factory pattern
module ActiveFacet
  class ResourceManager

    cattr_accessor :resource_mapper, :serializer_mapper

    # Default resource mapping scheme, can be overrided with config
    def self.default_resource_mapper(resource_class)
      [].tap do |map|
        until(resource_class.superclass == BasicObject) do
          map << resource_class.name.tableize
          resource_class = resource_class.superclass
        end
      end
    end
    self.resource_mapper = method(:default_resource_mapper)

    # TODO --jdc implement recursive superclass/parentclass lookup
    # Default serializer mapping scheme, can be overrided with config
    def self.default_serializer_mapper(resource_class, serializer, type, version, options)
      case type
      when :serializer
        [
          'V' + version.to_i.to_s + '::' + resource_class.name.camelcase + '::' + resource_class.name.camelcase + type.to_s.camelcase,
          'V' + version.to_i.to_s + '::' + resource_class.name.camelcase + type.to_s.camelcase,
        ].each { |name|
          klass = name.safe_constantize
          return klass.new if klass.present?
        }
      else
        [
          'V' + version.to_i.to_s + '::' + resource_class.name.camelcase + '::' + serializer + type.to_s.camelcase,
          'V' + version.to_i.to_s + '::' + serializer + type.to_s.camelcase,
        ].find { |name|
          klass = name.safe_constantize
          return klass if klass.present?
        }
      end
    end
    self.serializer_mapper = method(:default_serializer_mapper)

    # Singleton
    # @return [ResourceManager]
    def self.instance
      @instance ||= new
    end

    # (Memoized) Associate a serializer with a resource_class
    # @param resource_class [Object]
    # @param serializer [Serializer::Base]
    # @param namespace [String] (TODO --jdc currently unused)
    # @return [Array]
    def register(resource_class, serializer, namespace = nil)
      registry[resource_class] = [serializer, namespace]
    end

    # Fetches the serializer registered for the resource_class
    # @param resource_class [Object] to find serializer for
    # @param options [Hash] context
    # @return [Serializer::Base]
    def serializer_for(resource_class, options)
      fetch_serializer(resource_class, resource_class.name.demodulize.to_s.camelcase, :serializer, options)
    end

    # Fetches the attribute serializer registered for the given resource_class
    # @param resource_class [Object] to find attribute serializer class for
    # @param attribute_class_name [String] to find attribute serializer class for
    # @param options [Hash] context
    # @return [AttributeSerializer::Base]
    def attribute_serializer_class_for(resource_class, attribute_name, options)
      fetch_serializer(resource_class, attribute_name.to_s.camelcase, :attribute_serializer, options)
    end

    # Fetches the resource class registered for the serializer
    # @param serializer [Serializer::Base] to find resource class for
    # @return [Object]
    def resource_class_for(serializer)
      registry.each_pair do |resource_class, entry|
        return resource_class if serializer == entry[0]
      end
      nil
    end

    # Fetches the set of filter and field override indexes for resource_class
    # @param resource_class [Object]
    # @return [Array] of string indexes
    def resource_map(resource_class)
      memoized_resource_map[resource_class] ||= begin
        self.class.resource_mapper.call(resource_class)
      end
    end

    def extract_version_from_opts(options)
      ((options.try(:[], ActiveFacet.opts_key) || {})[ActiveFacet.version_key] || ActiveFacet.default_version).to_f
    end

    private

    attr_accessor :registry, :memoized_serializers, :memoized_resource_map

    # @return [ResourceManager]
    def initialize
      self.registry = {}
      self.memoized_serializers = {}
      self.memoized_resource_map = {}
    end

    # Retrieves serializer class from memory or lookup
    # @param resource_class [Class] the class of the resource to serialize
    # @param serializer [String] name of the base_class of the resource to serialize
    # @param type [String] type of serializer to look for (attribute vs. basic, etc.)
    # @param options [Hash] context
    # @return [Class] the first Class successfully described
    def fetch_serializer(resource_class, serializer, type, options)
      version = extract_version_from_opts(options)
      unless result = self.class.serializer_mapper.call(resource_class, serializer, type, version, options)
        error_message = "Unable to locate serializer for:: " + [resource_class.name, serializer, type, version].to_s
        Rails.logger.debug error_message
        raise ActiveFacet::Errors::LookupError.new(error_message) if ActiveFacet.strict_lookups
      end
      result
    end
  end
end
