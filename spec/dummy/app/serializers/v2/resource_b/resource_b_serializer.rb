module V2
  module ResourceB
    class ResourceBSerializer
      include ActiveFacet::Serializer::Base
      resource_class ::ResourceB
    end
  end
end
