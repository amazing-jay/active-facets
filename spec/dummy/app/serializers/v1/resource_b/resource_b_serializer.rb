module V1
  module ResourceB
    class ResourceBSerializer
      include RealCerealBusiness::Serializer::Base
      resource_class ::ResourceB
    end
  end
end
