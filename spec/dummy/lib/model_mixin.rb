module ModelMixin
  extend ActiveSupport::Concern

  included do
    belongs_to :parent, class_name: '::ResourceA'
    has_one :child, class_name: '::ResourceA'

    belongs_to :owner, class_name: '::ResourceB'
    has_many :delegates, class_name: '::ResourceB'
    has_many :others, class_name: '::ResourceB'
    has_many :extras, class_name: '::ResourceB'
  end

  def method_missing(method_sym, *arguments, &block)
    if method_sym == :dynamic_attr
      return dynamic_accessor
    elsif method_sym == :dynamic_attr=
      self.dynamic_accessor = arguments[0]
    end
  end

  private

  def private_attr
    private_accessor
  end

  def private_attr=(value)
    self.private_accessor = value
  end
end
